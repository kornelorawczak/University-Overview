using System;

namespace EShop.Domain.Common
{
    // Każda entity będzie dziedziczyć po tej klasie, automatycznie otrzymując ID
    public abstract class BaseEntity
    {
        public Guid Id { get; protected set; }

        protected BaseEntity()
        {
            Id = Guid.NewGuid(); 
        }
    }
}