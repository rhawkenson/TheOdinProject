const repeatString = function(texte, iterations) {
    let output = "";
    if (iterations < 0) {
        return "ERROR";
    }
    while (iterations > 0) {
        output += texte;
        iterations -= 1;
    }
    return output;
}

module.exports = repeatString
