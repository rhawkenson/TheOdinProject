class Hangman
  @@game_end = false
  
    def initialize
      print_title()
      choice = ""
      until ["N","L"].include?(choice)
        print "[N]ew game? [L]oad a saved game? "
        choice = gets.chomp
        choice.length > 0 ? choice = choice.to_s[0].upcase : choice = ""
      end
      puts ""
      if choice == "L" ? load_saved_game() : load_new_game()
      end
    end
  
    def print_title
      puts "============================================================"
      puts "       _    _                                         "
      puts "      | |  | |                                        "
      puts "      | |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __  "
      puts "      |  __  |/ _` | '_ \\ / _` | '_ ` _ \\ / _` | '_  \\ "
      puts "      | |  | | (_| | | | | (_| | | | | | | (_| | | | |"
      puts "      |_|  |_|\\__,_|_| |_|\\__, |_| |_| |_|\\__,_|_| |_|"
      puts "                           __/ |                      "
      puts "                          |___/     "
      puts "============================================================"
    end
  
    def load_new_game
      @board = Board.new
      @player ||= Player.new
      @player.tries = 8
      load_dictionary()
      word = select_word()
      @board.change_word(word)
      play_game()
    end
  
    def load_dictionary
      # load all dictionary in an array or randomly pick a line ?
      @dict_entries = []
      dictionary = File.open("5desk.txt", "r")
      while !dictionary.eof?
        line = dictionary.readline.strip
        if line.length > 4 && line.length < 13
          @dict_entries.push(line.upcase)
        end
      end
    end
  
    def select_word
      # then should select a random word of 5 to 12 chars
      @random_word = @dict_entries[rand(@dict_entries.length-1)]
      return @random_word
    end
  
    def play_game
      while !@@game_end and @player.tries_left?
        # display the word
        @board.update_display()
        # display previous misses
        puts "Misses: #{@board.misses.join(', ')}"
        # display tries
        puts "#{@player.tries} tries left"
        # ask for input
        player_guess = "" #dirtyhack
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
      puts "\nThe word was #{@board.word}!"
      if @@game_end
        puts "Congratulations, you won!"
      else
        puts "Try Again!"
      end
      print "\n[R]eplay, [L]oad game or any other key to exit. "
      key = gets.chomp
      if key.to_s[0] == "r" || key.to_s[0] == "R"
        @@game_end = false
        load_new_game()
      elsif key.to_s[0] == "l" || key.to_s[0] == "L"
        @@game_end = false
        load_saved_game()
      end
    end
  
    def load_saved_game
      # display the files that match the regex along with an index
      files = Dir.glob("./*.save").sort.reverse
      puts "============================================================"
      files.each_with_index do |file, idx|
        if idx < 9
          puts "\t#{idx} - #{file[2,file.length]}"
        end
      end
      puts "============================================================"
      gamesave_idx = ""
      while !gamesave_idx.match(/\d/) || gamesave_idx.to_i >= files.length
        print "Select file to open: "
        gamesave_idx = gets.chomp.to_s[0]
        if gamesave_idx.nil?
          initialize()
        end
      end
      filename = files[gamesave_idx.to_i]
      gamesave = File.open(filename, "r")
      data = Marshal.load(gamesave)
      @player, @board = data[0], data[1]
      puts "\nLoaded file #{filename}"
      puts "Welcome back #{@player.name}"
      play_game()
    end
  
    def save_game
      timestamp = Time.now.strftime("%Y%m%d-%H%M%S-")
      filename = "#{timestamp}#{@player.name}.save"
      data = Marshal.dump([@player, @board])
      File.open(filename, "w") { |gamesave| gamesave.puts data }
      puts "Game saved with filename #{filename}!"
    end
  
  end
  
  class Board
    attr_reader :word, :guess_history, :misses
  
    def initialize()
      @display = []
      @guess_history = []
      @misses = []
    end
  
    def change_word(word)
      # fill the display with _
      @word = word
      @display = ["_"] * (word.length)
    end
  
    def update_display
      # print a display of _ _ A _ N _ corresponding to the current @word
      print "\nWord: "
      @display.each do |ltr|
        print "#{ltr} "
      end
      puts ""
    end
  
    def guess_repeat?(player_guess)
      return @guess_history.include?(player_guess) ? true : false
    end
  
    def good_guess?(player_guess)
      @guess_history.push(player_guess)
      nb_found = 0
      word_array = @word.split('')
      word_array.each_with_index do |ltr, idx|
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
  
    def found_word?
      return @word == @display.join ? true : false
    end
  
  end
  
  class Player
    attr_accessor :tries
    attr_reader :name
  
    def initialize()
      @tries = 8
      @name ||= ask_player_name()
    end
  
    def ask_player_name
      name = ""
      while name.length < 1
        print "Hello! What's your name? "
        name = gets.chomp.to_s
      end
      puts "Welcome, #{name}!"
      return name
    end
  
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
  
    def tries_left?
      return tries <= 0 ? false : true
    end
  
  end
  
  new_game = Hangman.new
  
  