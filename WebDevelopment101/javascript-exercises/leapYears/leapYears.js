const leapYears = function(year) {
    
    if (!(Number.isInteger(year))) {
        return False;
    } else if (!(year >= 0)) {
        return False;
    } else {
        if (year % 100 === 0) {
           if (year % 400 === 0) {
               // Unless if they are also divisible by 400
               return true;
           } else {
               // However, years divisible by 100 are not leap years
               return false;
           }
            return false;
        } else if (year % 4 === 0) {
            return true;
        } else {
            return false;
        }
    }
}

module.exports = leapYears