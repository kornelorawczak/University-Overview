using System;
using System.Threading.Tasks;
using EShop.Domain.Common;
using EShop.Domain.Products;

namespace EShop.Infrastructure.Repositories
{
    public class ProductRepository : InMemoryRepository<Product>, IProductRepository
    {
        public ProductRepository()
        {
            // Seed
            var p1 = new Product("Laptop Gamingowy", "Super szybki laptop", new Money(4500, "PLN"), "LPT-001");
            p1.AddTag("Gaming");
            p1.AddTag("Promo"); 
            p1.Activate();
            
            var p2 = new Product("Mysz bezprzewodowa", "Ergonomiczna , lekka mysz", new Money(150, "PLN"), "MSE-020");
            p2.AddTag("Akcesoria");
            p2.Activate();

            var p3 = new Product("Telewizor 4K", "Idealny do filmów", new Money(2200, "PLN"), "TV-4K");

            _store.Add(p1.Id, p1);
            _store.Add(p2.Id, p2);
            _store.Add(p3.Id, p3);
        }
    }
}