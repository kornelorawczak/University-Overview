function createGenerator(n) {
    return function() {
        var _state = 0;
        return {
            next : function() {
                return {
                    value : _state,
                    done : _state++ >= n
                }
            }
        }
    }
}

var foo1 = {
    [Symbol.iterator] : createGenerator(10)
}

var foo2 = {
    [Symbol.iterator] : createGenerator(8)
}

for (x of foo1) {
    console.log(x);
}

for (x of foo2) {
    console.log(x);
}
