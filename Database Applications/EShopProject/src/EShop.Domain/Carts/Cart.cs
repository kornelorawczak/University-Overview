using System;
using System.Collections.Generic;
using System.Linq;
using EShop.Domain.Common;
using EShop.Domain.Products;

namespace EShop.Domain.Carts
{
    public class Cart : BaseEntity
    {
        private readonly List<CartItem> _items = new List<CartItem>();
        public IReadOnlyCollection<CartItem> Items => _items.AsReadOnly();

        public Guid? CustomerId { get; private set; } 
        public DateTime CreatedAt { get; private set; }

        public Cart(Guid? customerId)
        {
            CustomerId = customerId;
            CreatedAt = DateTime.UtcNow;
        }

        public void AddItem(Product product, int quantity)
        {
            if (product.Status != ProductStatus.Active)
            {
                throw new InvalidOperationException("Nie można dodać nieaktywnego produktu do koszyka.");
            }

            var existingItem = _items.FirstOrDefault(i => i.ProductId == product.Id);
            if (existingItem != null)
            {
                existingItem.IncreaseQuantity(quantity);
            }
            else
            {
                _items.Add(new CartItem(product, quantity));
            }
        }

        public void RemoveItem(Guid productId)
        {
            var item = _items.FirstOrDefault(i => i.ProductId == productId);
            if (item != null)
            {
                _items.Remove(item);
            }
        }

        public void ChangeItemQuantity(Guid productId, int newQuantity)
        {
            if (newQuantity <= 0)
            {
                RemoveItem(productId); // 0 lub mniej = usuwamy
                return;
            }

            var item = _items.FirstOrDefault(i => i.ProductId == productId);
            if (item != null)
            {
                // Korzystamy z gotowej metody w CartItem
                item.UpdateQuantity(newQuantity);
            }
        }

        public void Clear()
        {
            _items.Clear();
        }

        public Money TotalAmount()
        {
            if (!_items.Any()) return Money.Zero();
            
            var totalAmount = _items.Sum(i => i.TotalValue().Amount);
            var currency = _items.First().UnitPrice.Currency; 
            
            return new Money(totalAmount, currency);
        }
    }
}