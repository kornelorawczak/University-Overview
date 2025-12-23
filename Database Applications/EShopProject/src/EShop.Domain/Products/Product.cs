using System;
using EShop.Domain.Common;
using System.Collections.Generic; 
using System.Text.Json.Serialization;

namespace EShop.Domain.Products
{
    public class Product : BaseEntity
    {
        public string Name { get; private set; }
        public string Description { get; private set; }
        public Money Price { get; private set; }
        public string SKU { get; private set; } 
        public ProductStatus Status { get; private set; }

        [JsonInclude]
        public List<string> Tags { get; private set; } = new List<string>();

        public Product(string name, string description, Money price, string sku)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("Nazwa nie może być pusta");
            if (price.Amount < 0) throw new ArgumentException("Cena nie może być ujemna");

            Name = name;
            Description = description;
            Price = price;
            SKU = sku;
            Status = ProductStatus.Draft; 
        }

        [JsonConstructor] 
        public Product(Guid id, string name, string description, Money price, string sku, ProductStatus status, List<string> tags)
        {
            Id = id;
            Name = name;
            Description = description;
            Price = price;
            SKU = sku;
            Status = status;
            Tags = tags ?? new List<string>();
        }
        
        public void UpdateDetails(string name, string description)
        {
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException("Nazwa nie może być pusta");
            Name = name;
            Description = description;
        }

        public void ChangePrice(Money newPrice)
        {
            if (newPrice.Amount < 0) throw new ArgumentException("Cena nie może być ujemna");
            Price = newPrice;
        }

        public void Activate() => Status = ProductStatus.Active;
        public void Archive() => Status = ProductStatus.Archived;

        public void AddTag(string tag)
        {
            if (!Tags.Contains(tag))
            {
                Tags.Add(tag);
            }
        }

        public void UpdateTags(List<string> newTags)
        {
            Tags.Clear();
            if (newTags != null)
            {
                Tags.AddRange(newTags);
            }
        }

        public void RemoveTag(string tag)
        {
            Tags.Remove(tag);
        }
    }
}