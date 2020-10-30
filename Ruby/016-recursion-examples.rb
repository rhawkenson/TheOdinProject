roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
}

def int_to_roman(roman_mapping, nb, roman="")
	return roman if nb == 0
	roman_mapping.keys.each do |key|
		if nb >= key
			roman << roman_mapping[key]
			nb = nb - key
      break
    end
  end
	
	int_to_roman(roman_mapping, nb, roman)
end

def integer_to_roman(roman_mapping, number, result = "")
  return result if number == 0
  roman_mapping.keys.each do |divisor|
    quotient, modulus = number.divmod(divisor)
    result << roman_mapping[divisor] * quotient
    return integer_to_roman(roman_mapping, modulus, result) if quotient > 0
  end
end

p int_to_roman(roman_mapping, 5568)

p integer_to_roman(roman_mapping, 5568)

##################################################################


roman_to_int_mapping = {
  "M" => 1000,
  "CM" => 900,
  "D" => 500,
  "CD" => 400,
  "C" => 100,
  "XC" => 90,
  "L" => 50,
  "XL" => 40,
  "X" => 10,
  "IX" => 9,
  "V" => 5,
  "IV" => 4,
  "I" => 1
}


def roman_to_integer(roman_to_int_mapping, roman_nb, result=0)
  return result if roman_nb.length == 0

  roman_to_int_mapping.keys.each do |key|
    if roman_nb[0] == key
      result += roman_to_int_mapping[key]
      roman_nb = roman_nb[1,roman_nb.length]
      break
    end
  end

  roman_to_integer(roman_to_int_mapping, roman_nb, result)

end

p roman_to_integer(roman_to_int_mapping, "MMMMMDLXVIII")


##################################################################

def fact(n)
  (1..n).reduce(:*) || 1
end

p fact(5)

##################################################################


Prime.lazy.select { |x| x.to_s.include?('3') }.take(20).to_a
Prime.lazy.select { |x| 100.to_s.chars.map(&:to_i).inject(:+) }.take(20).to_a


##################################################################


(1..100).lazy.select { |x| x % 3 == 0 }.select { |x| x % 4 == 0 }.to_a

##################################################################

# split in half
m = n / 2

# recursive sorts
sort a[1..m]
sort a[m+1..n]

# merge sorted sub-arrays using temp array
b = copy of a[1..m]
i = 1, j = m+1, k = 1
while i <= m and j <= n,
    a[k++] = (a[j] < b[i]) ? a[j++] : b[i++]
    → invariant: a[1..k] in final position
while i <= m,
    a[k++] = b[i++]
    → invariant: a[1..k] in final position


## with inject
puts "Heaviest rock is: #{rocks.inject{|max_rock, rock| max_rock > rock ? max_rock : rock}}"


def rock_judger(r_arr)     
    count = r_arr.length
    a,b =  count <= 2 ? [r_arr[0], r_arr[-1]] : [rock_judger(r_arr.pop(count/2)), rock_judger(r_arr)]
    return a > b ? a : b
end

https://www.codequizzes.com/computer-science/beginner/recursion

def int_to_roman(nb, roman)
	return roman if nb == 0
	
	roman_mapping each do |key, value|
		if nb > key
			roman << roman_mapping[key]
			nb = nb - key
			break
	
	int_to_roman (nb, roman)
end


efficient recursion:
	- do not do again and again the same calculation
	- do not use too much stack space : use tail recursion (accumulating and calling again the function iteratively)
