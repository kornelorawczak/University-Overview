using System;

namespace EShop.Application.DTO
{
    public class ProductDto
    {
        public Guid Id { get; set; } 
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public string Sku { get; set; }
        public List<string> Tags { get; set; } = new List<string>();
    }
}