const express = require('express');
const multer = require('multer');
const path = require('path');
const http = require('http');
const app = express();

// Konfiguracja multer
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Katalog, gdzie będą zapisywane pliki
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  },
});

const upload = multer({ storage: storage });

app.set('view engine', 'ejs');
app.set('views', './views');

app.get('/', (req, res) => { 
    res.render('index');
});

app.post('/upload', upload.single('uploadedFile'), (req, res) => {
    if (!req.file || path.extname(req.file.originalname) !== '.txt') {
        return res.status(400).send('Błąd: Dozwolone są tylko pliki .txt');
    }
    console.log(req.file);
    res.render('success');
})

http.createServer(app).listen(3000);
console.log("started");