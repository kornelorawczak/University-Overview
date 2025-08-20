const moduleB = require("./moduleB");

module.exports = {
    name : 'Module A', 
    getBname : () => moduleB.name,
};