var A = new Set();
for (let i = 1; i <= 100000; i++) {
    var str = i.toString();
    var sum = 0;
    var p = true;
    for (let j = 0; j < str.length; j++) {
        if (i % str[j] != 0) {
            p = false; 
            break;
        }
        sum += Number(str[j]);
    }
    if ((p == true) && (i % sum == 0)) A.add(i); 
}
console.log(A)