A = new Set();
isprime = function(x) {
    for (let i = 2; i < x/2 + 1; i++) {
        if (x % i == 0) return false
    }
    return true;
}

for (let i = 2; i <= 100000; i++) {
    if (isprime(i)) A.add(i);
}

console.log(A);
