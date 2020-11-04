num_to_guess = rand(1..100) # Random Integer from 1 to 10

user_num = 0 # *Initializing* user_num
counter = 0

until user_num == num_to_guess
  puts 'Guess a number from 1 to 100!'
  user_num = gets.chomp.to_i # Turning user inpu into an integer
  if user_num > num_to_guess
    puts "too high!"
  elsif user_num < num_to_guess
    puts "too low!"
  end
  counter += 1
end

puts "You guessed right! it took you #{counter} times!"