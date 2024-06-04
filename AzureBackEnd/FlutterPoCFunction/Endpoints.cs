using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using ApiPoC.Entities;
using ApiPoC.Infra;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Devices;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace ApiPoC
{
    public class Endpoints
    {
        private static readonly string IoTHubConnectionString =
            Environment.GetEnvironmentVariable("IoTHubConnectionString", EnvironmentVariableTarget.Process);

        private readonly ServiceClient
            _serviceClient = ServiceClient.CreateFromConnectionString(IoTHubConnectionString);

        private readonly IProductRepository _productRepository;

        public Endpoints(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }

        [FunctionName("PostTriggerAsync")]
        public async Task<IActionResult> PostTriggerAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            var requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            await SendCloudToDeviceMessageAsync(requestBody, log);
            log.LogInformation("Received request body: {RequestBody}", requestBody);
            return new OkObjectResult(requestBody);
        }

        [FunctionName("PostProductsAsync")]
        public async Task<IActionResult> PostProductsAsync(
            [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            var requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            var products = JsonConvert.DeserializeObject<List<Product>>(requestBody);
            var stringBuilder = new StringBuilder();
            stringBuilder.AppendLine(" ");

            foreach (var product in products)
            {
                stringBuilder.AppendLine($"{products.IndexOf(product) + 1}. {product.Name}");
            }

            await SendCloudToDeviceMessageAsync(requestBody, log);
            log.LogInformation("Received request body: {RequestBody}", stringBuilder.ToString());
            return new OkObjectResult(requestBody);
        }

        [FunctionName("GetAllCategoriesWithProducts")]
        public IActionResult GetAllCategoriesWithProducts(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            var categoryProductCollections = _productRepository.GetAllCategoriesWithProducts();
            return new OkObjectResult(categoryProductCollections);
        }

        [FunctionName("GetListOfProductCategories")]
        public IActionResult GetListOfProductCategories(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            var categories = _productRepository.GetListOfProductCategories();
            return new OkObjectResult(categories);
        }

        [FunctionName("GetProductsByCategory")]
        public IActionResult GetProductsByCategory(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = $"{nameof(GetProductsByCategory)}/{{category}}")]
            HttpRequest req,
            ILogger log,
            string category)
        {
            var products = _productRepository.GetProductsByCategory(category).ToList();
            return new OkObjectResult(products);
        }

        [FunctionName(nameof(GetHeartBeat))]
        public IActionResult GetHeartBeat(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)]
            HttpRequest req,
            ILogger log)
        {
            var version = Assembly.GetExecutingAssembly().GetName().Version?.ToString() ?? "0.0.0.0";
            var workingUrl = $"{req.Scheme}://{req.Host}";
            var workingEnvironmentApi = "";

            if (workingUrl.ToLower().Contains("localhost"))
            {
                workingEnvironmentApi = "dev";
            }
            else if (workingUrl.ToLower().Contains("flutterpocfunction.azurewebsites.net"))
            {
                workingEnvironmentApi = "staging";
            }

            if (string.IsNullOrEmpty(workingEnvironmentApi))
            {
                throw new NullReferenceException("The working environment should have a value");
            }

            return new OkObjectResult(
                $"Hello I'm alive. My api version is {version}. It is connected to '{workingEnvironmentApi}'.");
        }

        private async Task SendCloudToDeviceMessageAsync(string response, ILogger log)
        {
            try
            {
                var ioTDeviceId = Environment.GetEnvironmentVariable("IoTDeviceId", EnvironmentVariableTarget.Process);
                var commandMessage = new Message(Encoding.ASCII.GetBytes(response));
                commandMessage.Properties.Add("timestamp", DateTime.UtcNow.ToString("o"));
                await _serviceClient.SendAsync(ioTDeviceId, commandMessage);
                log.LogInformation("Message sent to the device successfully");
            }
            finally
            {
                await _serviceClient.CloseAsync();
            }
        }
    }
}