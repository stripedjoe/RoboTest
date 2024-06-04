using IoTHubTrigger = Microsoft.Azure.WebJobs.EventHubTriggerAttribute;
using Microsoft.Azure.WebJobs;
using System.Text;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.EventHubs;
using Microsoft.Azure.WebJobs.Extensions.SignalRService;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs.Extensions.Http;

namespace IotHubPoCListener
{
    public class IoTHubListener
    {
        [FunctionName("IoTHubListener")]
        public static async Task Run(
            [IoTHubTrigger("messages/events", Connection = "ConnectionString")]
            EventData message,
            [SignalR(HubName = "PoCSignalR")] IAsyncCollector<SignalRMessage> signalrMessage,
            ILogger log)
        {
            if (message?.Body.Array == null)
            {
                log.LogInformation("No message body received");
                return;
            }

            var messageBody = Encoding.UTF8.GetString(message.Body.Array);
            log.LogInformation("C# IoT Hub trigger function processed a message: {MessageBody}", messageBody);

            await signalrMessage.AddAsync(new SignalRMessage
            {
                Target = "newSentMessage",
                Arguments = new[] { messageBody }
            });
        }

        [FunctionName("Negotiate")]
        public static SignalRConnectionInfo Negotiate(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)]
            HttpRequest req,
            [SignalRConnectionInfo(HubName = "PoCSignalR")]
            SignalRConnectionInfo connectionInfo)
        {
            return connectionInfo;
        }
    }
}