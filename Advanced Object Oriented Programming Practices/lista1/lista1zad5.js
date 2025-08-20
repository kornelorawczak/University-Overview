fib_it = function(n) {
    var a = 1;
    var b = 1;
    for (let i = 3; i <= n; i++) {
        var next = a + b;
        a = b;
        b = next;
    }
    return b;
}

fib_rec = function(n) {
    if (n == 2 || n == 1) return 1;
    return fib_rec(n - 1) + fib_rec(n - 2);
}

function time(n) {
    console.time("Rekurencja");
    fib_rec(n);
    console.timeEnd("Rekurencja");

    console.time("Iteracja");
    fib_it(n);
    console.timeEnd("Iteracja");
}

for (let i = 15; i <= 50; i+=10) {
    console.log("Czasy wykonania dla n = " + i);
    time(i);
}


