const express = require('express');
const http = require('http');
const app = express();

app.set('view engine', 'ejs');
app.set('views', './views');

app.get('/', (req, res) => {
    res.render('index');
})

http.createServer(app).listen(3000);
console.log("started");