const express = require('express');
const http = require('http');
const app = express();

app.set('view engine', 'ejs');
app.set('views', './views');


app.get('/', (req, res) => {
  res.render('index');
});

app.get('/download', (req, res) => {
  res.setHeader('Content-Type', 'text/plain');
  res.setHeader('Content-Disposition', 'attachment; filename="dynamic.txt"');

  const content = `Hello, world!\nCurrent Date and Time: ${new Date().toString()}`;

  const stream = require('stream');
  const readableStream = new stream.Readable({
    read() {
      this.push(content);
      this.push(null); 
    },
  });

  readableStream.pipe(res);
})

http.createServer(app).listen(3000);
console.log("started");
