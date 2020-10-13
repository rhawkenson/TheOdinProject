class Hangman
  @@game_end = false
  LINE_ART = "============================================================"

  #! initialize starts the game and prompts either for new or load game.
  def initialize
    print_title()
    choice = ""
    until choice == "N" or choice == "L"
      print "[N]ew game? [L]oad a saved game? "
      choice = gets.chomp.upcase
    end
    puts ""
    if choice == "L" ? load_saved_game() : load_new_game()
    end
  end

  private
  #! prints Ascii art title
  def print_title
    puts LINE_ART
    puts "       _    _                                         "
    puts "      | |  | |                                        "
    puts "      | |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __  "
    puts "      |  __  |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_  \\ "
    puts "      | |  | | (_| | | | | (_| | | | | | | (_| | | | |"
    puts "      |_|  |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|"
    puts "                           __/ |                      "
    puts "                          |___/     "
    puts LINE_ART
  end

  #! resets the board, create player if not existing, resets tries
  def load_new_game
    @board = Board.new
    @player ||= Player.new
    @player.tries = 8
    load_dictionary()
    word = select_word()
    @board.change_word(word)
    play_game()
  end

  #! load all words of 5-12 chars in an array but only if not already loaded
  def load_dictionary
    if !@dict_entries
      @dict_entries = []
      dictionary = File.open("5desk.txt", "r")
      while !dictionary.eof?
        line = dictionary.readline.strip
        if line.length > 4 && line.length < 13
          @dict_entries.push(line.upcase)
        end
      end
    end
  end

  #! select a random word of 5-12 chars
  def select_word
    return @dict_entries[rand(@dict_entries.length-1)]
  end

  #! main game loop
  def play_game
    while !@@game_end and @player.tries_left?
      # display the word
      @board.update_display()
      # display previous misses
      puts "Misses: #{@board.misses.join(', ')}"
      # display tries
      puts "#{@player.tries} tries left"
      # ask for input
      player_guess = ""
      while @board.guess_repeat?(player_guess) || !player_guess.match(/[a-zA-Z]+/)
        player_guess = @player.ask_guess()
        if player_guess == "#"
          save_game()
        end
      end
      # remove tries if miss
      if !@board.good_guess?(player_guess)
        @player.tries -= 1
      end
      # end game if word found
      @@game_end = @board.found_word?
    end
    # end of game message
    puts "\nThe word was #{@board.word}!"
    puts @@game_end ? "Congratulations, you won!" : "Try Again!"
    # replay message
    print "\n[R]eplay, [L]oad game or any other key to exit. "
    key = gets.chomp.upcase
    if key.to_s[0] == "R"
      @@game_end = false
      load_new_game()
    elsif key.to_s[0] == "L"
      @@game_end = false
      load_saved_game()
    end
  end

  #! display save files and load the file selected
  def load_saved_game
    # display the files that match the regex along with an index
    files = Dir.glob("./*.save").sort.reverse
    puts LINE_ART
    files.each_with_index do |file, idx|
      if idx < 9
        puts "\t#{idx} - #{file[2,file.length]}"
      end
    end
    puts LINE_ART
    # user selects a file to open. if enter without anything resets game.
    gamesave_idx = ""
    while !gamesave_idx.match(/\d/) || gamesave_idx.to_i >= files.length
      print "Select file to open: "
      gamesave_idx = gets.chomp.to_s[0]
      if gamesave_idx.nil?
        initialize()
      end
    end
    # load the file selected
    filename = files[gamesave_idx.to_i]
    gamesave = File.open(filename, "r")
    data = Marshal.load(gamesave)
    @player, @board = data[0], data[1]
    puts "\nLoaded file #{filename}"
    puts "Welcome back #{@player.name}"
    play_game()
  end

  #! create a gamesave file with name timestamp + player name
  def save_game
    filename = "#{Time.now.strftime("%Y%m%d-%H%M%S-")}#{@player.name}.save"
    data = Marshal.dump([@player, @board])
    File.open(filename, "w") { |gamesave| gamesave.puts data }
    puts "Game saved with filename #{filename}!"
  end
end
  
class Board
  attr_reader :word, :misses

  #! initialize the board variables
  def initialize()
    @display = []
    @guess_history = []
    @misses = []
  end

  #! updates the @word variable and fills the var display with underscores
  def change_word(word)
    @word = word
    @display = ["_"] * (word.length)
  end

  #! print a display of _ _ A _ N _ corresponding to the current @word
  def update_display
    print "\nWord: "
    @display.each { |ltr| print "#{ltr} " }
    puts ""
  end

  #! check if player input has already been entered or not
  def guess_repeat?(player_guess)
    return @guess_history.include?(player_guess) ? true : false
  end

  #! check if the player's input has a match in the word or not
  def good_guess?(player_guess)
    @guess_history.push(player_guess)
    nb_found = 0
    @word.split('').each_with_index do |ltr, idx|
      if ltr == player_guess
        @display[idx] = player_guess.upcase
        nb_found += 1
      end
    end
    # found letter + display number of occurrences
    if nb_found > 0
      puts "Found #{nb_found} #{player_guess} in this word!"
      return true
    else
      puts "Wrong guess, keep going!"
      @misses.push(player_guess)
      return false
    end
  end

  #! check if the word is completely found
  def found_word?
    return @word == @display.join ? true : false
  end

end
  
class Player
  attr_accessor :tries
  attr_reader :name

  #! initialize the player and his tries
  def initialize()
    @tries = 8
    @name = ask_player_name()
  end

  private
  #! get player name
  def ask_player_name
    name = ""
    while name.length < 1
      print "Hello! What's your name? "
      name = gets.chomp.to_s
    end
    puts "Welcome, #{name}!"
    return name
  end

  public
  #! ask player to pick a letter or offer to save the game
  def ask_guess
    player_guess = ""
    while !player_guess.match(/[a-zA-Z#]+/)
      print "Pick a letter! (or enter # to save the game) "
      player_guess = gets.chomp
      if player_guess.length > 0
        player_guess = player_guess.to_s[0].upcase
      end
    end
    return player_guess
  end

  #! confirm number of tries left
  def tries_left?
    return tries <= 0 ? false : true
  end

end

new_game = Hangman.new