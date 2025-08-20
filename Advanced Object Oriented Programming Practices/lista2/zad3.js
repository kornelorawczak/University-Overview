console.log((![] + [])[+[]]); // widzimy że jeśli pierwsze zwróci false albo true jako 
                              // napis, to potem odwołujemy się jak do indeksu
console.log(+[]); // zamiana na numeryczną poprzez + przed wyrażeniem (0 bo [] jest pusta)
console.log(![]); // tablica jest konwertowana na true 
// ![] + [] to próba konkatenacji false z tablica co daje stringa 'false'
console.log(+!+[]); // od prawej mamy 0 zanegowane na 1 i przekonwertowane na 1 num
console.log([][[]]); // undefined - odniesienie przez indeks w pustej tablicy
console.log([![]]);

console.log( (![]+[])[+[]]   +  // false indeks 0 = "f"
             (![]+[])[+!+[]] +  // false indeks 1 = "a"
             ([![]]+[][[]])[+!+[]+[+[]]]  + // 'falseundefined' indeks 10 = 'i'
             (![]+[])[!+[]+!+[]] ); // false indeks 2 = "l"
