using System;

namespace EShop.Application.DTO
{
    public class AddToCartDto
    {
        public Guid CartId { get; set; }
        public Guid ProductId { get; set; }
        public int Quantity { get; set; }
    }
}