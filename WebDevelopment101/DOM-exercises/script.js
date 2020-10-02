const container = document.querySelector('#container');

const div_text = document.createElement('div');
div_text.classList.add('content');
div_text.textContent = 'This is the glorious text-content!';
container.appendChild(div_text);

const red_p = document.createElement('p');
red_p.style.color = "#ff0000";
red_p.textContent = "Hey I’m red!"
container.appendChild(red_p);

const blue_h3 = document.createElement('h3');
blue_h3.style.color = "#0000ff";
blue_h3.textContent = "I’m a blue h3!";
container.appendChild(blue_h3);

const black_div = document.createElement('div');
black_div.style.backgroundColor = "pink";
black_div.style.border = "solid 1px #000000";

const yellow_h1 = document.createElement('h1');
yellow_h1.style.color = "yellow";
yellow_h1.textContent = "I'm in a div!";
black_div.appendChild(yellow_h1);

const regular_p = document.createElement('p');
regular_p.textContent = "ME TOO!";
black_div.appendChild(regular_p);

container.appendChild(black_div);

// buttons is a node list. It looks and acts much like an array.
const buttons = document.querySelectorAll('button');

// we use the .forEach method to iterate through each button
buttons.forEach((button) => {

  // and for each one we add a 'click' listener
  button.addEventListener('click', () => {
    alert(button.id);
  });
});