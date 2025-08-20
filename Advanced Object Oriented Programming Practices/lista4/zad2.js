var p = {
    name: "jan"
}
var q = {
    surname: "kowalski"    
}

Object.setPrototypeOf( p, q );


let objectField = function(o, field) {
    let proto = Object.getPrototypeOf(o); 
    if (proto[field] === undefined) return true;
    return false;
}
console.log(objectField(p, "name")); // z obiektu
console.log(objectField(p, "surname")); // z prototypu

function EnumerateFromObject(o) {
    return Object.keys(o);
}

function EnumerateFromProtoChain(o) {
    let fields = [];
    for (let key in o) {
        fields.push(key);
    }
    return fields;
}

console.log(EnumerateFromObject(p));
console.log(EnumerateFromProtoChain(p));