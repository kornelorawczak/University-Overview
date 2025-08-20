const mA = require("./moduleA");

console.log(mA.getBname());

// w CommonJs jest ok ponieważ eksportowane obiekty są udostępniane jako referencje
// w ESM moduły są ładowane w sposób statyczny, dlatego mogą wystąpić problemy z undefined