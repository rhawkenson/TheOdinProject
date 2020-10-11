class TicTacToe
  @@game_end = false
  @@player_turn = 1

  def initialize()
    start_game()
  end

  private
  def start_game()
    puts "\nGame starts!"
    @board = Board.new
    @players = []
    @players[1] = Player.new(1, "X")
    puts "Player 1 has symbol #{@players[1].symbol}"
    @players[2] = Player.new(2, "O")
    puts "Player 2 has symbol #{@players[2].symbol}"
    @@player_turn = 1 + rand(2)
    play_game()
  end
  
  def play_game()
    win_pattern = ""
    until @@game_end == true
      @board.display_board()
      get_player_move(@@player_turn, @players[@@player_turn].symbol)
      @@player_turn == 1 ? @@player_turn = 2 : @@player_turn = 1
      win_pattern = @board.win_situation?()
      if win_pattern != false or @board.full?
        @@game_end = true
        @board.display_board()
        puts "Game is finished!"
        if win_pattern == @players[1].symbol
          puts "Player 1 wins the game!"
        elsif win_pattern == @players[2].symbol
          puts "Player 2 wins the game!"
        else
          puts "It's a tie!"
        end
      end
    end
    print "\nReplay? [Y]es or any other key to exit. "
    key = gets.chomp
    if key.to_s[0].downcase == "y"
      @@game_end = false
      start_game()
    end
  end

  def get_player_move(id, symbol)
    # ask for the player's move
    puts "\nPlayer #{id}'s turn! Using the symbol #{symbol}"
    valid = false
    until valid
      print "Input the number of the cell selected: "
      player_move = gets.chomp
      valid = @board.fill_cell_valid?(player_move.to_i - 1, symbol)
    end
  end

end

class Player
  attr_reader :symbol
  def initialize(id, symbol)
    @id = id
    @symbol = symbol
  end
end

class Board

  def initialize()
    create_board()
  end

  private
  def create_board()
    @board_cells = []
    for i in (0..8)
      @board_cells[i] = BoardCell.new(i)
    end
  end

  public
  def display_board()
    # lazy way to display the board
    puts ""
    separator = [" | "," | ","\n"]
    for i in (0..8)
      print @board_cells[i].symbol + separator[i % 3]
    end
  end

  def fill_cell_valid?(position, symbol)
    if @board_cells[position] && @board_cells[position].empty
      @board_cells[position].fill_cell(symbol)
      puts ""
      return true
    else 
      return false
    end
  end

  def win_situation?()
    # lazy logic to check 9 patterns on the board
    # doesnt work btw
    win_patterns = [[0, 1, 2],[3, 4, 5],[6, 7, 8],
                    [0, 3, 6],[1, 4, 7],[2, 5, 8],
                    [0, 4, 8],[2, 4, 6]]
    win_patterns.each do |pattern|
      current_pattern = ""
      pattern.each do |i|
        current_pattern += @board_cells[i].symbol
      end
      if current_pattern == "XXX"
        return "X"
      elsif current_pattern == "OOO"
        return "O"
      end
    end
    return false
  end

  def full?()
    board_full = true
    for i in (0..8)
      if @board_cells[i].empty
        board_full = false
      end
    end
    return board_full
  end

end

class BoardCell
  attr_reader :position, :symbol, :empty

  def initialize(position)
    @empty = true
    @position = position.to_i
    @symbol = (position.to_i + 1).to_s
  end

  def fill_cell(symbol)
    @empty = false
    @symbol = symbol
  end

end

tictactoe = TicTacToe.new()