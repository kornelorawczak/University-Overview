using System;

namespace EShop.Domain.Common
{
    public record Money(decimal Amount, string Currency)
    {
        public static Money Zero(string currency = "PLN") => new Money(0, currency);

        public static Money operator +(Money a, Money b)
        {
            if (a.Currency != b.Currency) throw new InvalidOperationException("Nie można dodawać różnych walut!");
            return new Money(a.Amount + b.Amount, a.Currency);
        }
        
        public static Money operator *(Money a, int multiplier)
        {
            return new Money(a.Amount * multiplier, a.Currency);
        }
    }
}