const getTheTitles = function() {
    return arguments[0].map(book => book.title);
}

module.exports = getTheTitles;
