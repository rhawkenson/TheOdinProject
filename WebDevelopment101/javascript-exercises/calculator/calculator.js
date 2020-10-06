function add () {
	return Number(arguments[0] + arguments[1]);
}

function subtract () {
	return Number(arguments[0] - arguments[1]);
}

function sum () {
	return arguments[0].reduce((a, b) => a + b, 0);
}

function multiply () { 
	return arguments[0].reduce((a, b) => a * b);
}

function power() {
	return Number(Math.pow(arguments[0], arguments[1]));
}

function factorial(n, total = 1) {
	if (n === 0 || n === 1) {
		return total;
	} else {
		total = total * n;
		return factorial(n - 1, total);
	}
}

module.exports = {
	add,
	subtract,
	sum,
	multiply,
    power,
	factorial
}