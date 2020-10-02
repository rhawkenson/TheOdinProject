const ctof = function(tempCelsius) {
  // [°F] = [°C] × ​9⁄5 + 32 
  let tempFahrenheit = tempCelsius * (9/5) + 32;
  if (tempFahrenheit % 1 === 0.0) {
    tempFahrenheit = Math.round(tempFahrenheit);
  } else {
    tempFahrenheit = tempFahrenheit.toFixed(1);
  }
  return Number(tempFahrenheit);
}

const ftoc = function(tempFahrenheit) {
  // [°C] = ([°F] − 32) × ​5⁄9
  let tempCelsius = (tempFahrenheit - 32) * (5/9);
  if (tempCelsius % 1 === 0.0) {
    tempCelsius = Math.round(tempCelsius);
  } else {
    tempCelsius = tempCelsius.toFixed(1);
  }
  return Number(tempCelsius);
}

module.exports = {
  ftoc,
  ctof
}
