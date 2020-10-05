window.addEventListener('keydown', keyPress);

let pScore = 0;
let cScore = 0;
let round = 0;
let gameState = "play";
const pBoard = document.getElementsByClassName("playerboard")[0].children[1];
const cBoard = document.getElementsByClassName("computerboard")[0].children[1];
const aBoard = document.getElementsByClassName("announceboard")[0].children[1];
const sBoard = document.getElementsByClassName("scoreboard")[0].children[1];

function keyPress(e) {

    if (gameState === "end") {
        pBoard.textContent = "";
        cBoard.textContent = "";
        aBoard.textContent = "Game Start!";
        pScore = 0;
        cScore = 0;
        round = 0;
        sBoard.textContent = pScore + " - " + cScore;
        gameState = "play";
    }

    switch(e.keyCode) {
        case 65: game("rock", computerPlay());
                 break;
        case 83: game("paper", computerPlay());
                 break;
        case 68: game("scissors", computerPlay());
                 break;
    }

}

function computerPlay() {
    let randomInt = Math.floor((Math.random() * 3) + 1);
    if (randomInt === 1) {
        return "rock";
    } else if (randomInt === 2) {
        return "paper";
    } else {
        return "scissors";
    }
}

function game(pMove, cMove) {
    
    pBoard.textContent = pMove;
    cBoard.textContent = cMove;

    if (pMove === cMove) {
        aBoard.textContent = "It's a tie!";
    } else if (pMove === "rock" && cMove === "paper") {
        cScore += 1;
        aBoard.textContent = "Computer Wins! Paper beats Rock."
    } else if (pMove === "paper" && cMove === "rock") {
        pScore += 1;
        aBoard.textContent = "Player Wins! Paper beats Rock."
    } else if (pMove === "scissors" && cMove === "rock") {
        cScore += 1;
        aBoard.textContent = "Computer Wins! Rock beats Scissors."
    } else if (pMove === "rock" && cMove === "scissors") {
        pScore += 1;
        aBoard.textContent = "Player Wins! Rock beats Scissors."
    }  else if (pMove === "paper" && cMove === "scissors") {
        cScore += 1;
        aBoard.textContent = "Computer Wins! Scissors beat Paper."
    } else if (pMove === "scissors" && cMove === "paper") {
        pScore += 1;
        aBoard.textContent = "Player Wins! Scissors beat Paper."
    }

    sBoard.textContent = pScore + " - " + cScore;
    round += 1;
    console.log(round);
    console.log(gameState);

    if (round >= 10 || pScore >= 10 || cScore >= 10) {
        gameState = "end";
        if (pScore > cScore) {
            aBoard.textContent = "Game Over: Player Wins the Game!";
        } else if (cScore > pScore) {
            aBoard.textContent = "Game Over: Computer Wins the Game!";
        } else {
            aBoard.textContent = "Game Over: It's a Tie Game!";
        }
    }

}

