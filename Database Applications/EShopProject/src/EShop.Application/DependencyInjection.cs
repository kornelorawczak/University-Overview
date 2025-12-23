using Microsoft.Extensions.DependencyInjection;
using EShop.Application.Services;

namespace EShop.Application
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddApplication(this IServiceCollection services)
        {
            services.AddScoped<ProductService>();
            services.AddScoped<CartService>();
            
            return services;
        }
    }
}