const express = require('express');
const session = require('express-session');
const FileStore = require('session-file-store')(session); 
const http = require("http");

const app = express();

app.use(express.urlencoded({ extended: true }));

app.use(session({
  store: new FileStore({
    path: './sessions', 
    ttl: 3600, 
    retries: 1, 
  }),
  secret: 'fdioioaspiapbdsvouewj',
  resave: false, 
  saveUninitialized: false, 
  cookie: { maxAge: 3600000 } 
}));

app.set('view engine', 'ejs');
app.set('views', './views');

app.get("/", (req, res) => {
    var sessionValue = req.session.sessionValue;
    res.render('index', { sessionValue : sessionValue });
});

app.get('/set-session', (req, res) => {
    req.session.sessionValue = new Date().toString();
    res.redirect('/');
});

app.get('/delete-session', (req, res) => {
    req.session.destroy();
    res.redirect('/');
});

http.createServer(app).listen(3000);
console.log("start");