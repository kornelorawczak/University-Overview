// 1. różnica między . a []? 
const p1 = { 
    "typ obiektu" : "testowy"
};
// polega na tym że [] zawiera w środku stringa, więc możemy napisać p1['typ obiektu'],
// lecz za pomocą kropki nie da się odnieść do tego pola bezpośrednio

// 2. argumenty inne niż string dla []
const pt = {
    toString : function() {
        return "custom object";
    } 
}
const p2 = {
    a : 1,
    b : 2,
    "c" : 3,
    "4" : 4
}
p2[pt] = 5;
/*
console.log(p2[4]); // automatyczna konwersja liczby na stringa i szukanie pola "4"
console.log(p2[pt]); // obiekt wewnątrz [] jest konwertowany na jego toString() - 
                     // bazowo jest to [object Object], ale możemy zmienić
console.log(p2);
console.log(p2['custom object']);
*/

// 3. operator [] dla tablicy (Tablica to OBIEKT!)
const tab = ['jeden', 'dwa', 'trzy', 'cztery'];
tab['A'] = 'pole A';
/*
console.log(tab['0']); // konwersja stringa na numer 
console.log(tab.length); // pole o kluczu 'A' nie liczy się do długości tablicy
console.log(tab['A']); // ale można się do niego odwołać jak do normalnego obiektu
// tab[object] działa tak samo jak w 2
console.log(tab);
tab.length = 5; // pojawia się empty item 
console.log(tab);
tab.length = 2; // zabiera nadmiarowe elementy tablicy
console.log(tab);
*/  