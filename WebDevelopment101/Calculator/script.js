const screen = document.getElementById("calc_screen");
const sourcecode = document.getElementById("sourcecode");
let operator = "";
let n1, n2, result;
let calcstate = "wipeme";

// Main function to call the mathematical operations

function operate(operator, nb1, nb2) {
    nb1 = Number(nb1);
    nb2 = Number(nb2);
    switch(operator) {
        case "+": result = add(nb1, nb2); break;
        case "-": result = subtract(nb1, nb2); break;
        case "*": result = multiply(nb1, nb2); break;
        case "/": result = divide(nb1, nb2); break;
        case "%": result = modulo(nb1, nb2); break;
        case "^": result = power(nb1, nb2); break;
        case "!": result = factorial(nb1); break;
        case "√": result = squareroot(nb1); break;
    }
    n1 = screen.textContent = Math.round(result * 100 + Number.EPSILON) / 100;
    if (nb2) {
        sourcecode.textContent += `\n${nb1} ${operator} ${nb2} = ${result}\n`;
    } else if (operator === "!") {
        sourcecode.textContent += `\n${nb1}${operator} = ${result}\n`;
    } else if (operator === "√") {
        sourcecode.textContent += `\n${operator}${nb1} = ${result}\n`;
    }

    sourcecode.scrollTop = sourcecode.scrollHeight;
    calcstate = "wipeme";
}

// Capture inputs through the graphical interface

document.addEventListener("click", e => {

    switch (e.target.className) {
        case "gridnumber": calc_add_number(e.target.textContent); break;
        case "gridc": calc_clearc(); break;
        case "gridce": calc_clearce(); break;
        case "griddot": calc_add_dot(); break;
        case "gridoperator": calc_add_operator(e.target.textContent); break;
        case "gridequal": calc_equal(); break;
    }
    screen.scrollLeft = screen.scrollWidth;
});

// Capture inputs through the keyboard

document.addEventListener("keydown", e => {
    if (/[0-9]/.test(e.key)) { calc_add_number(e.key); }
    else {
        switch (e.key) {
            case "Escape":
            case "Delete": calc_clearc(); break;
            case "Backspace": calc_clearce(); break;
            case ".": calc_add_dot(); break;
            case "+":
            case "-":
            case "*":
            case "/":
            case "%":
            case "!":
            case "^": calc_add_operator(e.key); break;
            case "=":
            case "Enter": calc_equal(); break;
        }
    }
    screen.scrollLeft = screen.scrollWidth;
});

// Functions that are called by both keyboard and mouse

function calc_add_number(number) {
    if (calcstate === "wipeme") {
        calcstate = "leavemealone";
        screen.textContent = "";
    }
    if (screen.textContent == 0 && number != 0) {
            screen.textContent = number;
    } else if(!(/[\!\√]+/.test(screen.textContent))) {
        screen.textContent += number;
    }
}

function calc_clearc() { 
    calcstate = "leavemealone";
    screen.textContent = "";
    n1 = 0;
    n2 = 0;
    operator = "";
}

function calc_clearce() {
    calcstate = "leavemealone";
    screen.textContent = screen.textContent.slice(0, screen.textContent.length - 1);
}

function calc_add_dot() {
    if (calcstate === "wipeme") {
        calcstate = "leavemealone";
        screen.textContent = "";
    }

    if ((/[\!\√]+/.test(screen.textContent))) {
        // do nothing because factorial or squareroot
    } else if (!screen.textContent.includes(".")) {
        // no dot
        screen.textContent += ".";
    } else if ((/[\*\/\+\-\!\^\%]+/.test(screen.textContent)) &&
            !(/[\*\/\+\-\!\^\%]+.+\./.test(screen.textContent))) {
        // dot and operator but no right dot
        screen.textContent += ".";
    }
}

function calc_add_operator(op) {
    calcstate = "leavemealone";
    // if we have an operand and a number and we press a new operand we compute
    if ((/[\*\/\+\-\!\^\%]+.+\d+/.test(screen.textContent)) ||
        (/[\!\√]+/.test(screen.textContent))) {
        calc_equal();
        calcstate = "leavemealone";
    } else {
        n1 = screen.textContent.replace(/[^0-9|.]/g, '');
        // if we have a dot but no number
        if (!(/\d+/g.test(n1))) { n1 = 0; }
    }
    operator = op;
    if (op === "!") {
        screen.textContent = `${n1}${operator}`;
    } else if (op === "√") {
        screen.textContent = `${operator}${n1}`;
    } else {
        screen.textContent = `${n1} ${operator} `;
    }
}

function calc_equal() {
    if ((/[\!\√]+/.test(screen.textContent)) && n1) {
        operate(operator, n1);
    } else if ((/\d+.+[\*\/\+\-\!\^\%]+.+\d+/.test(screen.textContent))) {
        let operation = screen.textContent.split(' ');
        n1 = operation[0];
        operator = operation[1];
        n2 = operation[2];
        if (operator == "/" && n2 == 0) {
            screen.textContent = "Can't divide by 0";
            calcstate = "wipeme";
        } else { operate(operator, n1, n2); }
    }
}

// Mathematical functions

function add(a, b) { return a + b; }
function subtract(a, b) { return a - b; }
function divide(a, b) { return a / b; }
function multiply(a, b) { return a * b; }
function power(a, power) { return Math.pow(a, power); }
function modulo(a, b) { return a % b; }
function squareroot(a) { return Math.sqrt(a); }
function factorial(n, total = 1) {
	if (n === 0 || n === 1) {
		return total;
	} else {
		total = total * n;
		return factorial(n - 1, total);
	}
}

