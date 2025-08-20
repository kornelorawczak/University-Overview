const fs = require('fs');
const util = require('util');

fs.readFile("./zad4.txt", "utf-8", (err, data) => {
    if (err) {
        console.log("Deteced an error: " + err);
    }
    else {
        console.log(data);
    }
})

//sposób pierwszy
function readFileAsync(name, enc) {
    return new Promise( (res, rej) => {
        fs.readFile(name, enc, (err, data) => { 
            if (err) {
                rej(err);
            }
            else {
                res(data);
            }
        });
    });
}

//sposób drugi 
const readFile2 = util.promisify(fs.readFile);
readFile2("./zad4.txt", "utf-8")
    .then((data) => console.log(data))
    .catch((err) => console.log(err));

//sposób trzeci
fs.promises.readFile("./zad4.txt", "utf-8")
    .then((data) => console.log(data))
    .catch((err) => console.log(err));


(async function f() {
    let data = await readFileAsync("./zad4.txt", "utf-8");
    console.log(data);
})();