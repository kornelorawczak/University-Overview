// strona podatna na atak web parameter tampering
var http = require('http');
var express = require('express');
var crypto = require('crypto');
var secret = "ahooiasbdjbo";

var app = express();

app.get("/faktura/:id", (req, res) => {
    res.end(`Wygenerowana faktura z prywatnymi danami nr. ${req.params.id}`);
    // bez żadnych zabezpieczeń jesteśmy podatni na atak wpt - wystarczy że 
    // użytkownik zmieni url na inny i będzie mógł podejrzeć czyjąś fakturę
    var hmac = crypto.createHmac('sha256', secret).update(req.params.id).digest("hex");
    console.log(hmac);
    // to jest pierwsza opcja zabezpieczeń - szyfrowanie parametru, 
    // numer faktury użytkownika zamieniami na hmac i to jest adres url który dostaje
    // użytkownik, dzięki temu nie będzie wiedział jak dostać się do czyjejś faktury
});

http.createServer(app).listen(3000);
console.log("started");

// drugą opcją jest podawanie w url parametru jawnego i jego szyfru, 
// serwer wykona sobie walidacje, sprawdzi czy szyfrując parametr znanym 
// serwerowi kodem dostanie podany w url szyfr, jeśli nie to odrzuci żądanie get