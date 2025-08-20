var n = 1;
var o = {}
console.log(typeof Object.getPrototypeOf(n)); 
console.log(Object.getPrototypeOf(n) instanceof Object);
console.log(typeof Object.getPrototypeOf(o));

n.foo = "foo";
console.log(n.foo);

// JS automatycznie tworzy prototyp dla typów prostych są to puste obiekty
// do których nie da się wprost przypisać składowych bo są usuwane z pamięci 