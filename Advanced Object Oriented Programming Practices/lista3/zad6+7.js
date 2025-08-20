function* fib_g() { 
    let f1 = 0;
    let f2 = 1;
    while(true) {
        [f2, f1] = [f1 + f2, f2];
        yield f2;
    }
}

function fib_i() {
    let _f1 = 0;
    let _f2 = 1;
    return {
        next : function() {
            [_f2, _f1] = [_f1 + _f2, _f2];
            return {
                value: _f2,
                done: false
            }
        }
    }
}


function* take(it, top) {
    let i = 0;
    while (i < top) {
        yield it.next().value;
        i++;
    }
}

for (let num of take(fib_g(), 10)) {
    console.log(num);
}