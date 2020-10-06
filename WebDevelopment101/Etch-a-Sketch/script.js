const colorPalette = ['']

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
    return '#' + n.slice(0, 6);
}

document.addEventListener("mouseover", event => {
    if (event.target.className === "gridcell") {
        console.log(event.target);
        event.target.style.backgroundColor = randomHexColor();
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

generateGrid(16);