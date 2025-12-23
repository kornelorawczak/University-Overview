using System;
using System.Threading.Tasks;
using EShop.Application.DTO;
using EShop.Domain.Carts;
using EShop.Domain.Products;

namespace EShop.Application.Services
{
    public class CartService
    {
        private readonly ICartRepository _cartRepository;
        private readonly IProductRepository _productRepository;

        public CartService(ICartRepository cartRepository, IProductRepository productRepository)
        {
            _cartRepository = cartRepository;
            _productRepository = productRepository;
        }

        public async Task<Cart> GetOrCreateCartAsync(Guid? cartId)
        {
            if (cartId.HasValue)
            {
                var cart = await _cartRepository.GetByIdAsync(cartId.Value);
                if (cart != null) return cart;
            }

            // brak ID -> stwórz nowy
            var newCart = new Cart(null); 
            await _cartRepository.AddAsync(newCart);
            return newCart;
        }

        public async Task AddToCartAsync(AddToCartDto dto)
        {
            var cart = await _cartRepository.GetByIdAsync(dto.CartId);
            if (cart == null) throw new Exception("Cart not found");

            var product = await _productRepository.GetByIdAsync(dto.ProductId);
            if (product == null) throw new Exception("Product not found");

            cart.AddItem(product, dto.Quantity);

            await _cartRepository.UpdateAsync(cart);
        }

        public async Task UpdateItemQuantityAsync(UpdateCartItemDto dto)
        {
            var cart = await _cartRepository.GetByIdAsync(dto.CartId);
            if (cart == null) throw new Exception("Cart not found");

            cart.ChangeItemQuantity(dto.ProductId, dto.NewQuantity);

            await _cartRepository.UpdateAsync(cart);
        }

        public async Task RemoveItemAsync(Guid cartId, Guid productId)
        {
            var cart = await _cartRepository.GetByIdAsync(cartId);
            if (cart != null)
            {
                cart.RemoveItem(productId);
                await _cartRepository.UpdateAsync(cart);
            }
        }

        public async Task ClearCartAsync(Guid cartId)
        {
            var cart = await _cartRepository.GetByIdAsync(cartId);
            if (cart != null)
            {
                cart.Clear();
                await _cartRepository.UpdateAsync(cart);
            }
        }
    }
}