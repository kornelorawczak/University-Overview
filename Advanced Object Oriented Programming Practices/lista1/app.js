p = {
    _a : 1, 
    get b() {
        return p._a;
    }
};

p._a = 2;
console.log(p.b);