using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using EShop.Domain.Common;
using System.Text.Json;

namespace EShop.Infrastructure.Repositories
{
    public abstract class InMemoryRepository<T> : IRepository<T> where T : BaseEntity
    {
        // Słownik: Klucz (Guid) -> Wartość (Obiekt)
        protected readonly Dictionary<Guid, T> _store = new Dictionary<Guid, T>();

        private T DeepClone(T entity)
        {
            if (entity == null) return null;
            var json = JsonSerializer.Serialize(entity);
            return JsonSerializer.Deserialize<T>(json);
        }

        public Task<T> GetByIdAsync(Guid id)
        {
            if (_store.ContainsKey(id))
            {
                var entity = _store[id];
                return Task.FromResult(DeepClone(entity)); // zwracamy kopie
            }
            return Task.FromResult<T>(null);
        }

        public Task<IEnumerable<T>> GetAllAsync()
        {
            var allEntities = _store.Values.Select(e => DeepClone(e)).ToList();
            return Task.FromResult(allEntities.AsEnumerable());       
        }

        public Task AddAsync(T entity)
        {
            // Zapisujemy tylko kopie, aby tylko update wpływał na baze
            if (!_store.ContainsKey(entity.Id))
            {
                _store.Add(entity.Id, DeepClone(entity));
            }
            return Task.CompletedTask;
        }

        public Task UpdateAsync(T entity)
        {
            if (_store.ContainsKey(entity.Id))
            {
                _store[entity.Id] = DeepClone(entity);
            }
            return Task.CompletedTask;
        }

        public Task DeleteAsync(Guid id)
        {
            if (_store.ContainsKey(id))
            {
                _store.Remove(id);
            }
            return Task.CompletedTask;
        }
    }
}