function sum(...tab) {
    let sum = 0;
    for (x of tab) { 
        sum += x;
    }
    return sum;
}

console.log(sum(1,2,3,4));