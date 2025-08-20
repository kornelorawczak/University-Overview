function forEach(a, f) { 
    let i = 0;
    while (i < a.length) {
        f(a[i]);
        i++;
    }
}

function map(a, f) {
    let i = 0;
    let b = [];
    while (i < a.length) {
        b.push(f(a[i]));  
        i++;  
    }
    return b;
}

function filter(a, f) { 
    let i = 0;
    let b = [];
    while (i < a.length) {
        if (f(a[i])) b.push(a[i]);
        i++;  
    }
    return b;
}

let a = [1,2,3,4];

forEach(a, console.log);
console.log(map(a, (_ => 2 * _)));
console.log(filter(a, (_ => _ % 2 == 0)))