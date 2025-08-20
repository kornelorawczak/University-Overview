function forEach<T>(a : T[], f : (_ : T) => any) : any { 
    let i : number = 0;
    while (i < a.length) {
        f(a[i]);
        i++;
    }
}

function map<T>(a : T[], f : ((_ : T) => T)) : T[] {
    let i : number = 0;
    let b : T[] = [];
    while (i < a.length) {
        b.push(f(a[i]));  
        i++;  
    }
    return b;
}

function filter<T>(a : T[], f : (_ : T) => boolean) : T[]{ 
    let i : number = 0;
    let b : T[] = [];
    while (i < a.length) {
        if (f(a[i])) b.push(a[i]);
        i++;  
    }
    return b;
}

let array : number[] = [1,2,3,4];

forEach<number>(array, console.log);
console.log(map<number>(array, (_ => 2 * _)));
console.log(filter<number>(array, (_ => _ % 2 == 0)))