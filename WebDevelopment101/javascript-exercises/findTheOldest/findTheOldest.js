let findTheOldest = function(people) {
    
    return people.reduce(function(a, b) {
        let currentYear = new Date().getFullYear();

        let aAge = a.yearOfDeath - a.yearOfBirth ? a.yearOfDeath - a.yearOfBirth : currentYear - a.yearOfBirth;

        let bAge = b.yearOfDeath - b.yearOfBirth ? b.yearOfDeath - b.yearOfBirth : currentYear - b.yearOfBirth;

        return aAge < bAge ? b : a;
    });
}

module.exports = findTheOldest
