console.log(typeof 12); // zwraca string jako nazwa typu prymitywnego
console.log(typeof "sada");
console.log(typeof {} == typeof []); // nie nadaje się do obiektów

function Person() {}
const john = new Person();
console.log(john instanceof Person); // sprawdza przynależność do typów złożonych
console.log("hello" instanceof String); // false ponieważ typ prymitywny vs instancja złożonego
console.log(new String("hello") instanceof String); // true
