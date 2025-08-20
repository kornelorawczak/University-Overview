const http = require('https');

function fetchDataToPromise(url) {
    return new Promise((resolve, reject) => {
        http.get(url, function(resp) {
            let buf = "";

            resp.on('data', (data) => {
                buf += data.toString();
            });

            resp.on('end', () => {
                resolve(buf);
            });

            resp.on('error', (err) => { // bląd w trakcie pobierania danych ze strony
                reject(err);
            });

        }).on('error', (err) => { // błąd przy łączeniu ze stroną
            reject(err);
        });
    });
}

fetchDataToPromise('https://www.zalando.pl/')
    .then((data) => {
        console.log(data);
    })
    .catch((error) => {
        console.error(`Błąd: ${error.message}`);
    });