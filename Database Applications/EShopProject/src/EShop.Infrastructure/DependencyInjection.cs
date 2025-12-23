using Microsoft.Extensions.DependencyInjection;
using EShop.Domain.Carts;
using EShop.Domain.Products;
using EShop.Infrastructure.Repositories;

namespace EShop.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services)
        {
            // Singleton zamiast Scoped, aby dane nie znikały po każdym odświeżeniu strony.
            services.AddSingleton<IProductRepository, ProductRepository>();
            services.AddSingleton<ICartRepository, CartRepository>();
            
            return services;
        }
    }
}