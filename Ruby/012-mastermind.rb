class Mastermind
  @@game_won = false

  def initialize
    start_game()
  end

  def start_game
    @tries = 0
    @difficulty = 0
    puts "Welcome to the game!"
    until @difficulty > 0 and @difficulty < 7
      puts "Choose difficulty of the code (min = 3, max = 6): "
      @difficulty = gets.chomp.to_i
    end
    until @tries > 0 and @tries < 19
      puts "Choose number of tries allowed (min = 4, max = 18): "
      @tries = gets.chomp.to_i
    end
    @player1 = Player.new("Player", @tries)
    @computer1 = Computer.new(@difficulty)
    @board1 = Board.new(@tries, @difficulty)
    play_game()
  end

  def play_game
    while !@@game_won and @player1.tries_left?
      # ask player for a combination and remove a try
      player_guess = get_player_guess()
      # check with computer if won or not
      cows, bulls = @computer1.check_guess(player_guess)
      puts "#{bulls} bulls and #{cows} cows. #{@player1.tries} tries left."
      if @computer1.code_found?(player_guess)
        @@game_won = true
        puts "Player wins the game!"
      end
    end
    if !@@game_won
      puts "Player loses!"
      puts "The code was #{@computer1.code.join}!"
      print "\nReplay? [Y]es or any other key to exit. "
      key = gets.chomp
      if key.to_s[0].downcase == "y"
        @@game_won = false
        start_game()
      end
    end
  end

  def get_player_guess
    valid = false
    until valid
      puts "\nEnter a combination of #{@difficulty} numbers"
      player_guess = gets.chomp
      player_guess = player_guess.split('')
      player_guess.map!(&:to_i)
      if player_guess.all?(Integer) && player_guess.length >= @difficulty
        puts "Received code: #{player_guess.join[0,@difficulty]}"
        @tries -= 1
        valid = true
      end
    end
    return player_guess
  end

end

class Board
  def initialize(tries, difficulty)
    @nb_lines = tries
    @nb_cells = difficulty
  end
end

class Computer
  attr_reader :code
  def initialize(difficulty)
    @code = []
    for i in (0...difficulty)
      @code.push(rand(10))
    end
  end
  def code_found?(player_guess)
    code_found = true
    player_guess.each_with_index do |nb, idx|
      if nb != @code[idx]
        code_found = false
      end
    end
    return code_found
  end
  def check_guess(player_guess)
    cows = 0
    bulls = 0
    player_guess.each_with_index do |guess, idx|
      if @code[idx] == guess
        bulls += 1
      elsif @code.include?(guess) && @code[idx] != guess
        cows += 1
      end
    end
    return cows, bulls
  end
end

class Player
  attr_reader :name
  attr_accessor :tries
  def initialize(name, tries=12)
    @name = name
    @tries = tries
    @score = 0
  end
  def tries_left?
    @tries -= 1
    return @tries < 0 ? false : true
  end
end

new_game = Mastermind.new()