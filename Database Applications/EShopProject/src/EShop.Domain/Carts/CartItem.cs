using System;
using EShop.Domain.Common;
using EShop.Domain.Products;

namespace EShop.Domain.Carts
{
    public class CartItem : BaseEntity
    {
        public Guid ProductId { get; private set; }
        public string ProductName { get; private set; } 
        public Money UnitPrice { get; private set; }
        public int Quantity { get; private set; }

        public CartItem(Product product, int quantity)
        {
            if (quantity <= 0) throw new ArgumentException("Ilość musi być większa od zera");

            ProductId = product.Id;
            ProductName = product.Name;
            UnitPrice = product.Price;
            Quantity = quantity;
        }

        public void IncreaseQuantity(int amount)
        {
            Quantity += amount;
        }

        public void UpdateQuantity(int quantity)
        {
             if (quantity <= 0) throw new ArgumentException("Ilość musi być dodatnia");
             Quantity = quantity;
        }

        public Money TotalValue()
        {
            return UnitPrice * Quantity;
        }
    }
}