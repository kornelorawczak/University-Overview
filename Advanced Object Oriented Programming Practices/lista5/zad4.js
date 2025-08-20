const fs = require('fs');

fs.promises.readFile("./zad4.txt", "utf-8")
    .then( (data) => {
        console.log(data);
    })