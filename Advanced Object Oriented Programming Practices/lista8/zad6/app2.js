// strona oporna na atak csrf przez zabezpieczenie przez token csrf
const express = require('express');
const app = express();
const http = require('http');
const csrf = require('csurf');
const cookieParser = require('cookie-parser');

app.use(express.urlencoded({extended : true}));
app.use(cookieParser());

app.set('view engine', 'ejs');
app.set('views', './views');

app.use(csrf({ cookie: true })); // ustawiamy middleware tokena csrf

const user = { name: 'Jan Kowalski', balance: 1000 };

app.get('/', (req, res) => {
  res.render('csrf_protected', { user, csrfToken: req.csrfToken() });
  // przesyłamy generowany przez serwer token csrf do strony, 
  // jeśli ktoś będzie chciał nas zaatakować to nie będzie znać 
  // tego tokena i przez to atak zostanie wyłapany
});

app.post('/transfer', (req, res) => {
  const { amount } = req.body;
  user.balance -= parseInt(amount);
  res.render('transfer', {amount: amount, balance : user.balance});
});

app.use((err, req, res, next) => {
    if (err.code === 'EBADCSRFTOKEN') {
      res.status(403).send('Błąd CSRF: Nieautoryzowane żądanie.');
    } else {
      next(err);
    }
});


http.createServer(app).listen(3000);
console.log("started");