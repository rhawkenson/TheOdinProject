let brush = "black";
let fxColor = "#000000";
const rainbow = ['#ff0000','#ffa500','#ffff00','#008000','#0000ff','#4b0082','#ee82ee'];
let rbColor = 0;

function generateGrid(gridsize) {
    const container = document.getElementById("container");
    const grid = document.createElement("div");
    grid.classList.add("gridbase");
    grid.id = "gridbase";
    grid.style.gridTemplateRows = `autofill(${gridsize}, 1fr))`;
    grid.style.gridTemplateColumns = `repeat(${gridsize}, 1fr)`;

    let cellCount = 0;
    for (let i = 0; i < gridsize; i++) {
        for (let j = 0; j < gridsize; j++) {
            // add divs
            let cell = document.createElement("div");
            cell.id = `pixel ${cellCount}`;
            cell.style.gridArea = `${i + 1} / ${j + 1} / span 1 / span 1`;
            cell.classList.add("gridcell");
            grid.appendChild(cell);
            cellCount++;
        }
    }
    container.appendChild(grid);
    document.querySelector("body").appendChild(container);
}

function randomHexColor() {
    let n = (Math.random() * 0xfffff * 1000000).toString(16);
    let hexColor = '#' + n.slice(0, 6);
    document.getElementById("colorpicker").style.backgroundColor = hexColor;
    return hexColor;
}

function brushColor() {
    switch(brush) {
        case "black": return "#000000";
            break;
        case "rainbow": return rainbowColor();
            break;
        case "fixed": return fxColor;
            break;
        case "hexrandom": return randomHexColor();
            break;
    }
}

function rainbowColor() {
    rbColor = rbColor + 1 < rainbow.length ? rbColor + 1 : 0;
    document.getElementById("colorpicker").style.backgroundColor = rainbow[rbColor];
    return rainbow[rbColor];
}

function fixedColor() {
    fxColor = randomHexColor();
}

document.addEventListener("mouseover", event => {
    if (event.target.className === "gridcell") {
        console.log(event.target);
        event.target.style.backgroundColor = brushColor();
    }
});

document.getElementById("resetbtn").addEventListener("click", event => {
    let gridsize = 0;
    while(!Number.isFinite(gridsize) || gridsize <= 0 || gridsize > 100) {
        gridsize = Number(prompt("Size of the grid"))
    }
    console.log(gridsize);
    let container = document.getElementById("container");
    container.removeChild(container.childNodes[0]);
    generateGrid(gridsize);
});

document.getElementById("blackbtn").addEventListener("click", event => {
    brush = "black";
    document.getElementById("colorpicker").style.backgroundColor = "#000000";
});

document.getElementById("rainbowbtn").addEventListener("click", event => {
    brush = "rainbow";
});

document.getElementById("fixrandombtn").addEventListener("click", event => {
    brush = "fixed";
    fixedColor();
});

document.getElementById("randomhexbtn").addEventListener("click", event => {
    brush = "hexrandom";
});

generateGrid(16);