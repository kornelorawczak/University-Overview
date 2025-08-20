function Foo(type) {
    this.type = type;
    this.say = function() {
        return this.type;
    }
    //function Qux() {
    //    console.log("private method QUX");
    //}
    //this.Bar = function () {
    //    Qux();
    //}
}

Foo.prototype.Bar = function() {
    function Qux2() { 
        console.log("private method QUX v2");
    }
    Qux2();
}



var f1 = new Foo("t1");
// Foo.Qux();
// f1.Qux();
f1.Bar();
// Foo.Qux2();