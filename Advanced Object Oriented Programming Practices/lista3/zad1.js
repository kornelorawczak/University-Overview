function fib(n) {
    if(n < 3) return 1;
    else return fib(n-1) + fib(n-2);
}

function fib_memo(n, cache = {}) { 
    if (n < 3) return 1;
    if (cache[n]) return cache[n];
    cache[n] = fib_memo(n - 1, cache) + fib_memo(n - 2, cache);
    return cache[n];
}

for (let i = 15; i <= 45; i += 15) {
    const start1 = Date.now();
    fib(i);
    const end1 = Date.now();

    const start2 = Date.now();
    fib_memo(i);
    const end2 = Date.now();

    console.log(`Dla i = ${i}; Rekurencja -> ${end1 - start1}; Memoizacja -> ${end2 - start2}`);
}