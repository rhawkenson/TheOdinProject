const fibonacci = function(token, n=1, p=0) {
    token = Number(token);
    if (token < 0) {
        return "OOPS";
    } else {
        return (token - 1) === 0 ? n : fibonacci(token - 1, n + p, n);
    }
}

module.exports = fibonacci
