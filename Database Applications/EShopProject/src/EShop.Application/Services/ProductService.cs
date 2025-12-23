using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EShop.Application.DTO;
using EShop.Domain.Common;
using EShop.Domain.Products;

namespace EShop.Application.Services
{
    public class ProductService
    {
        private readonly IProductRepository _productRepository;

        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }


        public async Task<IEnumerable<Product>> GetBrowseableProductsAsync()
        {
            var allProducts = await _productRepository.GetAllAsync();
            return allProducts.Where(p => p.Status == ProductStatus.Active);
        }

        public async Task<Product> GetByIdAsync(Guid id)
        {
            return await _productRepository.GetByIdAsync(id);
        }


        public async Task<IEnumerable<Product>> GetAllProductsForManagerAsync()
        {
            return await _productRepository.GetAllAsync();
        }

        public async Task CreateProductAsync(ProductDto dto)
        {
            var currency = "PLN"; 
            var price = new Money(dto.Price, currency);
            
            var product = new Product(dto.Name, dto.Description, price, dto.Sku);
            if (dto.Tags != null && dto.Tags.Any())
            {
                product.UpdateTags(dto.Tags);
            }
            product.Activate(); 

            await _productRepository.AddAsync(product);
        }

        public async Task UpdateProductAsync(ProductDto dto)
        {
            var product = await _productRepository.GetByIdAsync(dto.Id);
            if (product == null) throw new Exception($"Product with id {dto.Id} not found");

            product.UpdateDetails(dto.Name, dto.Description);
            product.ChangePrice(new Money(dto.Price, "PLN"));
            product.UpdateTags(dto.Tags);

            await _productRepository.UpdateAsync(product);
        }

        public async Task DeleteProductAsync(Guid id)
        {
            await _productRepository.DeleteAsync(id);
        }
    }
}