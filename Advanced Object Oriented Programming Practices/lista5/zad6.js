const fs = require('fs');
const readline = require('readline');

(async function f() {
    const ips = new Map();

    const fstream = fs.createReadStream("./logs.txt");
    const rl = readline.createInterface({
        input : fstream,
        crlfDelay: Infinity
    });

    for await (const line of rl) {
        const parts = line.split(' ');
        const ip = parts[1];
        if(ip) {
            ips.set(ip, (ips.get(ip) || 0) + 1);
        }
    }
    const sortedips = Array.from(ips.entries()).sort((a,b) => b[1] - a[1]).slice(0,3);
    sortedips.forEach(([ip, count]) => {
        console.log(`${ip}: ${count}`);
    })
})();

