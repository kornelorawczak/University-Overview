let p1 = { 
    age : 19,
    yearofbirth : function() { return 2024 - age },
    set name(x) { this._name = x },
    get name() { return this._name }
}

console.log(p1.name);
p1.name = "mark";
console.log(p1.name);

//p1.surname = "Kowalski"; 
Object.defineProperty(p1, "surname", { value : "Kowalski" });
console.log(p1.surname);

console.log(p1);
Object.defineProperty(p1, "introduce", { value : `Hello Im ${p1.name}`}); // czemu this._name nie dziala?
console.log(p1.introduce);

Object.defineProperty(p1, "color", { // get oraz set nie da się inaczej, trzeba DefineProperty
    get : function() { return color },
    set : function(x) { color = x }
})

p1.color = "yellow";
console.log(p1.color);
