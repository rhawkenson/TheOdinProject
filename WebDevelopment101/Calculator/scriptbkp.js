const screen = document.getElementById("calc_screen");
const sourcecode = document.getElementById("sourcecode");
let operator = "";
let n1, n2, result;
let calcstate = "wipeme";

function operate(operator, nb1, nb2) {
    nb1 = Number(nb1);
    nb2 = Number(nb2);
    switch(operator) {
        case "+": result = add(nb1, nb2); break;
        case "-": result = subtract(nb1, nb2); break;
        case "*": result = multiply(nb1, nb2); break;
        case "/": result = divide(nb1, nb2); break;
        case "!": result = factorial(nb1); break;
        case "%": result = modulo(nb1, nb2); break;
    }
    screen.textContent = result;
    if (nb2) {
        sourcecode.textContent += `\n${nb1} ${operator} ${nb2} = ${result}`;
    } else {
        sourcecode.textContent += `\n${nb1} ${operator} = ${result}`;
    }
    
    sourcecode.scrollTop = sourcecode.scrollHeight;
    calcstate = "wipeme";
}

document.addEventListener("click", event => {

    switch (event.target.className) {
        case "gridnumber":
            if (calcstate === "wipeme") {
                calcstate = "leavemealone";
                screen.textContent = "";
            }
            if (screen.textContent.length === 1 && Number(screen.textContent) === 0) {
                if (Number(event.target.textContent) === 0) {
                    //do nothing because its just leading zeros.
                } else {
                    screen.textContent = event.target.textContent;
                }
            } else {
                screen.textContent += event.target.textContent;
            }
            break;
        case "gridc":
            calcstate = "leavemealone";
            screen.textContent = "";
            break;
        case "gridce":
            calcstate = "leavemealone";
            screen.textContent = screen.textContent.slice(0, screen.textContent.length - 1);
            break;
        case "griddot":
            if (calcstate === "wipeme") {
                calcstate = "leavemealone";
                screen.textContent = "";
            }
            if (!screen.textContent.includes(".")) {
                screen.textContent += ".";
            } else if (!(/[\*\/\+\-\!\^\%]+.+\./.test(screen.textContent))) {
                screen.textContent += ".";
            }
            break;
        case "gridoperator":
            calcstate = "leavemealone";
            n1 = screen.textContent.replace(/[^0-9|.]/g, '');
            operator = event.target.textContent;
            screen.textContent = `${n1} ${operator} `;
            break;
        case "gridequal":
            n2 = screen.textContent.slice(n1.length+3, screen.textContent.length);
            if (operator != "" && n1 && n2 && n2 != ".") {
                operate(operator, n1, n2);
            } else if (operator === "!" && n1) {
                operate(operator, n1, n2);
            }
            break;
    }
    screen.scrollLeft = screen.scrollWidth;
});

document.addEventListener("keydown", event => {
    // if a digit, capture and input to screen
    if (/[0-9]/.test(event.key)) {
        if (screen.textContent.length === 1 && Number(screen.textContent) === 0) {
            if (Number(event.key) === 0) {
                //do nothing because its just leading zeros.
            } else {
                screen.textContent = event.key;
            }
        } else {
            screen.textContent += event.key;
        }
        screen.scrollLeft = screen.scrollWidth;
    }

    // if not a digit, check against recognized keys
    switch (event.key) {
        case "Escape":
        case "Delete":
            screen.textContent = "";
            break;
        case "Backspace":
            screen.textContent = screen.textContent.slice(0, screen.textContent.length - 1);
            break;
        case ".":
            if (!screen.textContent.includes(".")) {
                screen.textContent += ".";
            }
            break;
        case "+":
        case "-":
        case "*":
        case "/":
        case "%":
        case "!":
        case "^":
            // operations
            n1 = screen.textContent.replace(/[^0-9|.]/g, '');
            operator = event.key;
            screen.textContent = `${n1} ${operator} `;
            break;
        case "=":
        case "Enter":
            n2 = screen.textContent.slice(n1.length+3, screen.textContent.length);
            if (operator != "" && n1 && n2 && n2 != ".") {
                operate(operator, n1, n2);
            } else if (operator === "!" && n1) {
                operate(operator, n1, n2);
            }
            break;
    }

});

function add () {
	return (arguments[0] + arguments[1]);
}

function subtract () {
	return (arguments[0] - arguments[1]);
}

function divide () {
	return (arguments[0] / arguments[1]);
}

function multiply () { 
	return (arguments[0] * arguments[1]);
}

function power() {
	return Math.pow(arguments[0], arguments[1]);
}

function factorial(n, total = 1) {
	if (n === 0 || n === 1) {
		return total;
	} else {
		total = total * n;
		return factorial(n - 1, total);
	}
}

function modulo() { 
	return (arguments[0] % arguments[1]);
}