const fs = require('fs');
const path = require('path');

function generateRandomIP() {
    return Array(4)
        .fill(0)
        .map(() => Math.floor(Math.random() * 256))
        .join('.');
}

function generateLogEntry() {
    const time = `${String(Math.floor(Math.random() * 24)).padStart(2, '0')}:${String(
        Math.floor(Math.random() * 60)
    ).padStart(2, '0')}:${String(Math.floor(Math.random() * 60)).padStart(2, '0')}`;
    const ip = generateRandomIP();
    const requestTypes = ['GET', 'POST', 'PUT', 'DELETE'];
    const resources = ['/index.html', '/TheApplication/WebResource.axd', '/api/data', '/contact.html'];
    const statusCodes = [200, 404, 500, 302];

    return `${time} ${ip} ${requestTypes[Math.floor(Math.random() * requestTypes.length)]} ${
        resources[Math.floor(Math.random() * resources.length)]
    } ${statusCodes[Math.floor(Math.random() * statusCodes.length)]}`;
}

function generateLogs(filename, lines) {
    const filePath = path.resolve(__dirname, filename);
    const writeStream = fs.createWriteStream(filePath);

    for (let i = 0; i < lines; i++) {
        writeStream.write(generateLogEntry() + '\n');
    }

    writeStream.end(() => console.log(`Wygenerowano ${lines} linii w pliku ${filename}`));
}

generateLogs('logs.txt', 100000); 
