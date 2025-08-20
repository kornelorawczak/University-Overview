function getLastProto(o) {
    var p = o;
    do {
        o = p;
        p = Object.getPrototypeOf(o); // ostatni prototyp to Object.prototype
    } while (p);
    return o;
}

let o = {};
let o1 = {};
let b = {};
Object.setPrototypeOf(o1, o);

console.log(getLastProto(o1) === getLastProto(b));