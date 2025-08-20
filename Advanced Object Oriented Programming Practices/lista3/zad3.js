function createFs(n) { 
    var fs = [];
    for (let i = 0; i < n; i++) {
        fs[i] = function() { return i; };
    }
    return fs;
}

var myfs = createFs(10);

console.log(myfs[0]());
console.log(myfs[2]());
console.log(myfs[7]());

// var wiąże funkcyjnie a let blokowo, dlatego przy var i mamy tylko jedną zmienną i
// która jest nadpisywana w tej pętli i dochodzi do i = 10 i taka wartość jest potem zwracana
// natomiast let wiąże blokowo i zapamiętuje dla każdego indeksu dobrą wartość

function createFs2(n) { 
    var fs = [];
    for (var i = 0; i < n; i++) {
        fs[i] = (function(i) {
            return function() { return i; };
        })(i);
    }
    return fs;
}

// tworzymy nową funkcje z parametrem która od razu jest wykonywana dlatego dobra wartość i jest zapamiętywana 

var myfs2 = createFs2(10);

console.log(myfs2[0]()); 
console.log(myfs2[2]()); 
console.log(myfs2[7]()); 
