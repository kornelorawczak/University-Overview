let fib = function(n : number) : number {
    if (n < 3) {
        return 1;
    }
    else return fib(n-1) + fib(n-2);
}

let memo = function <T extends number | string | symbol, G> (f : (n : T) => G) : ((n : T) => G) {
    var cache : {[key in T] : G} = {} as { [key in T]: G};
    return function(n : T) : G {
        if (n in cache) {
            return cache[n];
        }
        else {
            let result : G = f(n);
            cache[n] = result;
            return result;
        }
    }
}

let memofib : ((n : number) => number) = memo<number, number>(fib);

console.log(fib(45));
console.log(fib(45));
//console.log(memofib(45));
//console.log(memofib(45));