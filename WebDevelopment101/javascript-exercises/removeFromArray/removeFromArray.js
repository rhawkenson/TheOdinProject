function removeFromArray() {

    let myArray = Array.from(arguments[0]);

    for (i = 1; i < arguments.length; i++) {
        if (myArray.indexOf(arguments[i]) > -1) {
            myArray.splice(myArray.indexOf(arguments[i]), 1);
        } 
    }

    return myArray;
}

module.exports = removeFromArray
