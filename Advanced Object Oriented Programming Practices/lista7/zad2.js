var https = require('https');
var fs = require('fs');

(async function() {
    var pfx = await fs.promises.readFile('certificate.pfx')
    https.createServer(
        {
            pfx: pfx,
            passphrase: 'test'
        },
        (req, res) => {
            res.setHeader('Content-type', 'text/html; charset=utf-8');
            res.end(`Hello World! It's ${new Date()}`);
        }
    ).listen(3000)
    console.log("start");
})();

// certyfikat jest, ale nie jest poświadczony zatem będzie wykryty jako nie prywatny
// https://localhost:3000