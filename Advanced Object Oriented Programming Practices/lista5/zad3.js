function getRandomIntRange(max) {
    return Math.floor(Math.random() * max);
}

function guessing_game() { 
    const number = getRandomIntRange(100);
    process.stdout.write("Podaj Liczbe od 0 do 100: ");
    process.stdin.on("data", (data) => {
        const guessed = +data;
        if (guessed > number) { process.stdout.write("Za dużo! Spróbuj ponownie \n"); } 
        else if (guessed < number) { process.stdout.write("Za mało! Spróbuj ponownie \n"); }
        else {         
            process.stdout.write("Gratuluje! "); 
            process.stdin.end(); 
            process.exit();
        }
    })
}
guessing_game();