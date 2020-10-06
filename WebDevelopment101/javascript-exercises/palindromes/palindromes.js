const palindromes = function() {
    let text = arguments[0].replace(/[^a-zA-Z]/g, '').toLowerCase();
    let start = text.slice(0, Math.floor((text.length) / 2));
    let end = text.slice(Math.ceil((text.length) / 2), text.length);
    if (start === end.split("").reverse().join("")) {
        return true;
    } else {
        return false;
    }
}

module.exports = palindromes
