// strona podatna na atak csrf
const express = require('express');
const app = express();
const http = require('http');

app.use(express.urlencoded({extended : true}));

app.set('view engine', 'ejs');
app.set('views', './views');

const user = { name: 'Jan Kowalski', balance: 1000 };

app.get('/', (req, res) => {
  res.render('csrf_example', { user });
});

app.post('/transfer', (req, res) => {
  const { amount } = req.body;
  user.balance -= parseInt(amount);
  res.render('transfer', {amount: amount, balance : user.balance});
});

// atak csrf - odpal stronę i odpal plik attack_csrf.html

http.createServer(app).listen(3000);
console.log("started");