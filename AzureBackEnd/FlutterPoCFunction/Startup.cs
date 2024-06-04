using ApiPoC.Infra;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;

[assembly: FunctionsStartup(typeof(ApiPoC.Startup))]

namespace ApiPoC
{
    public class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            // Register services
            builder.Services.AddSingleton<IProductRepository, ProductRepository>();
        }
    }
}
