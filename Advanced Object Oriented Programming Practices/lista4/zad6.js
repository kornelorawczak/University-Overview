function Queue() {
    this.elements = []; 
    this.length = function() {
        return this.elements.length;
    }
    this.insert = function(x) {
        this.elements.push(x);
    }
    this.pop = function() {
        let popped = this.elements[0];
        this.elements = this.elements.splice(1);
        return popped;
    }
}


function Tree(val, left, right) {
    this.left = left;
    this.right = right;
    this.val = val;
}

var root = new Tree(1, new Tree( 2, new Tree( 3 ) ), new Tree( 4 ));

//  1
// 2 4
//3


Tree.prototype[Symbol.iterator] = function*() {
    const q = new Queue();
    q.insert(this);
    while(q.length() > 0) {
        const node = q.pop();
        if (node.left) q.insert(node.left); 
        if (node.right) q.insert(node.right); 
        yield node.val;
    }
} 

for (const e of root) {
    console.log(e);
}

