// Worker.prototype = Object.create( Person.prototype ); 
// takie podejście sprawia że prototypem Worker jest pusty obiekt którego 
// prototypami są prototypy Person. Dzięki temu tworząc nowe pola w Worker.prototype, 
// nie tworzymy ich też w Person.prototype

// Worker.prototype = Person.prototype;
// Tutaj jest taki problem że W.p to jest to samo w pamięci co P.p, przez co 
// niemożliwym jest dodać coś do prototypu Worker, bez dodawania tego do prototypu Person

// Worker.prototype = new Person(); 
// W tym przypadku problem jest taki że Worker będzie dziedziczyć po instancji Person,
// Więc jeśli ta będzie miała wartości z konstruktora to je podziedziczymy bez wyboru