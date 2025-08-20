var http = require('http');
var express = require('express');
var app = express();


app.set('view engine', 'ejs');
app.set('views', './views');
app.use(express.urlencoded({extended : true}));

app.get('/', (req, res) => {
    res.render('index', {name : '', surname : '', class_name : '', tasks : [0,0,0,0,0,0,0,0,0,0]})
})

app.post('/', (req, res) => {
    if (req.body.name && req.body.surname && req.body.class_name) {
        //res.render('print', {name : req.body.name, surname : req.body.surname, class_name : req.body.class_name, tasks : req.body.tasks})
        res.redirect(`/print?name=${req.body.name}&surname=${req.body.surname}&class_name=${req.body.class_name}&tasks=${JSON.stringify(req.body.tasks)}`)
    }
    else {
        res.render('index', {name : '', surname : '', class_name : '', tasks : [0,0,0,0,0,0,0,0,0,0], message : "Please insert full name, surname and class name to continue"})
    }
})

app.get('/print', (req, res) => {
    const { name, surname, class_name, tasks } = req.query;
    res.render('print', {name : name, surname : surname, class_name : class_name, tasks : JSON.parse(tasks)})
})

http.createServer(app).listen(3000);
console.log("started");