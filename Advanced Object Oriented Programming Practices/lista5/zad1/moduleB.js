const moduleA = require('./moduleA');

module.exports = {
    name: 'Module B',
    getAName: () => moduleA.name,
};
