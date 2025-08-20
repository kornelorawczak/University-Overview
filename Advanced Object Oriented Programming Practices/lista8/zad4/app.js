const http = require('http');
const express = require('express');
const app = express();
const cookieParser = require('cookie-parser');
const session = require('express-session');
const fileStore = require('session-file-store');

app.disable("etag");
app.use(cookieParser());
app.use(express.urlencoded({extended : true}));

app.use(session({resave : true, saveUninitialized : true, secret : "bufdssdbfsdkabs"}));

app.set('view engine', 'ejs');
app.set('views', './views');

  

app.get("/", (req, res) => {
    var cookieValue = req.cookies.testCookie;
    var sessionValue = req.session.sessionValue;
    res.render('index', { cookieValue : cookieValue, sessionValue : sessionValue });
});

app.post('/set-cookie', (req, res) => {
    res.cookie('testCookie', new Date().toString());
    res.redirect('/');
});

app.post('/delete-cookie', (req, res) => {
    res.clearCookie('testCookie');
    res.redirect('/');
});

app.get('/set-session', (req, res) => {
    req.session.sessionValue = new Date().toString();
    res.redirect('/');
});

app.get('/delete-session', (req, res) => {
    delete req.session.sessionValue;
    res.redirect('/');
});

http.createServer(app).listen(3000);
console.log("start");