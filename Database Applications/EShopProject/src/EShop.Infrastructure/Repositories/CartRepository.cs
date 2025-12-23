using EShop.Domain.Carts;

namespace EShop.Infrastructure.Repositories
{
    public class CartRepository : InMemoryRepository<Cart>, ICartRepository
    {
        
    }
}