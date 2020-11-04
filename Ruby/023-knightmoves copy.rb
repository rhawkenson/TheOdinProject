class Chessboard
  @@grid = []
  attr_reader :grid
  def initialize
    @@grid = Array.new
    for i in 1..8
      for j in 1..8
        @@grid.push([i,j])
      end
    end
  end
  def self.allowed?(move)
    return true if @@grid.include? move
    return false
  end
end

# class Knight
#   attr_accessor :pos
#   def initialize(pos = [1, 1])
#     @pos = pos
#   end
#   def moves
#     x = @pos[0]
#     y = @pos[1]
#     potential_moves = [[x + 2, y + 1],[x + 2, y - 1],[x + 1, y + 2],[x + 1, y - 2],
#     [x - 2, y + 1],[x - 2, y - 1],[x - 1, y + 2],[x - 1, y - 2]]
#     possible_moves = []
#     potential_moves.each do |move|
#       possible_moves.append(move) unless Chessboard.allowed?(move) == false
#     end
#     return possible_moves
#   end
#   def go_to(end_pos)
    
#   end
# end

class Node
  attr_reader :pos, :parent
  def initialize(pos, parent = nil)
    @pos = pos
    @parent = parent
  end
end

class Path
  attr_reader :root
  def initialize(root = nil)
    @root = root
  end

  def path_to(start_pos, end_pos)
    @root = Node.new(start_pos)
    queue = []
    queue2 = []
    queue.push(@root)
    found = false
    found_node = nil
    steps = 0

    until found
      until (queue.empty? || found) do
        if queue[0].pos == end_pos
          found = true
          found_node = queue[0]
        else
          queue2.push(queue[0])
          queue.shift
        end
      end
      queue2.each do |node|
        get_moves(node.pos).each do |move|
          queue.push(Node.new(move, node))
        end
        queue2.shift
      end
      steps += 1 unless found
    end

    if found
      p "Found a path in #{steps} steps!"
      cursor = found_node
      path_nodes = []
      until cursor.parent.nil?
        path_nodes.push(cursor.pos)
        cursor = cursor.parent
      end
      print "#{start_pos}"
      path_nodes.reverse.each do |node|
        print " -> #{node}"
      end
      print "\n"
    end
  end

  def get_moves(pos)
    x = pos[0]
    y = pos[1]
    potential_moves = [[x + 2, y + 1],[x + 2, y - 1],[x + 1, y + 2],[x + 1, y - 2],
    [x - 2, y + 1],[x - 2, y - 1],[x - 1, y + 2],[x - 1, y - 2]]
    possible_moves = []
    potential_moves.each do |move|
      possible_moves.append(move) unless Chessboard.allowed?(move) == false
    end
    return possible_moves
  end
end

my_chess = Chessboard.new
# my_knight = Knight.new([8,8])
# p my_knight.pos
# p my_knight.moves

my_path = Path.new
my_path.path_to([1,1], [1,8])