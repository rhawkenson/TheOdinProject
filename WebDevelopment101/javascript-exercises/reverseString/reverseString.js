const reverseString = function(texte) {
    let output = texte.split('').reverse().join('');
    return output;
}

module.exports = reverseString
