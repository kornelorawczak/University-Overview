process.stdout.write("podaj swoje imie: ");

process.stdin.on("data", (data) => {
    const name = data.toString().trim();
    console.log(`Witaj, ${name}!`);
    process.stdin.end();
    process.exit();
})