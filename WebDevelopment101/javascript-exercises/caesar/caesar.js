const caesar = function(text, i) {

    function ascii (a) {
        if (/[a-z]/.test(a)) {
            let base26 = (a.codePointAt(0) % 97) + (i % 26);
            base26 = base26 < 0 ? (26 + base26) % 26 : base26 % 26;
            return String.fromCodePoint(base26 + 97);
        } else if (/[A-Z]/.test(a)) {
            let base26 = (a.codePointAt(0) % 65) + (i % 26);
            base26 = base26 < 0 ? 26 + base26 % 26 : base26 % 26;
            return String.fromCodePoint(base26 + 65);
        } else {
            return a;
        }
    }
    return text.split('').map(ascii).join('');
}

module.exports = caesar
