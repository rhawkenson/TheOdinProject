const sumAll = function() {

    if (Number.isInteger(arguments[0]) && Number.isInteger(arguments[1])) {
        if (arguments[0] >= 0 && arguments[1] >= 0){
            let myMin = Math.min(arguments[0], arguments[1]);
            //console.log("myMin is " + myMin);
            let myMax = Math.max(arguments[0], arguments[1]);
            //console.log("myMax is " + myMax);
            let sum = 0;
            let i = myMin;
            while (i <= myMax) {
                //console.log("i is equal to " + i);
                sum += i;
                //console.log("sum is equal to " + sum);
                i += 1;
            }
            return sum;
        }
        return "ERROR";
    }
    return "ERROR";
}

module.exports = sumAll
