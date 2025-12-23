using System;

namespace EShop.Application.DTO
{
    public class UpdateCartItemDto
    {
        public Guid CartId { get; set; }
        public Guid ProductId { get; set; }
        public int NewQuantity { get; set; }
    }
}