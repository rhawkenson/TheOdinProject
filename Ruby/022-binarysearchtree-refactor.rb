class Node
  attr_accessor :left, :right, :value, :parent
  def initialize(value = nil, parent = nil, left = nil, right = nil)
    @left = left
    @right = right
    @parent = parent
    @value = value
  end
end

class Tree
  attr_accessor :root
  def initialize(arr)
    @root = build_tree(arr)
  end
  def build_tree(arr, parent = nil)
    return nil unless arr.last
    arr = arr.uniq.sort
    root = Node.new(arr[(arr.length)/2], parent)
    root.left = build_tree(arr[0, arr.length/2], root)
    root.right = build_tree(arr[arr.length/2+1, arr.length], root)
    return root
  end
  def insert(value, node=@root)
    value = value.to_i
    # only adding if > or < so if its == its ignored by default
    if value < node.value
      node.left == nil ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.value
      node.right == nil ? node.right = Node.new(value) : insert(value, node.right)
    end
  end
  def delete(value, root = @root)
    return root if root.nil?
    if value < root.value
      root.left = delete(value, root.left)
    elsif value > root.value
      root.right = delete(value, root.right)
    else
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.left
        root = nil
        return temp
      end
      temp = next_big(root)
      root.value = temp.value
      root.right = delete(temp.value, root.right)
    end
    return root
  end
  def next_big(root)
    next_big = root.right
    until next_big.left.nil?
      next_big = next_big.left
    end
    next_big
  end
  def find(value, node = @root)
    # find a value and return the Node with this value
    return node if node.value == value
    if node.left && value < node.value
      find(value, node.left)
    elsif node.right && value > node.value
      find(value, node.right)
    else
      puts "#{value} not in tree"
    end
  end
  def level_order
    # returns an array of values
    # after traversing the tree in BFS
    # need an array acting as a queue to keep track
    node = @root
    queue = [node]
    output = []
    until queue.empty?
      queue.push(queue[0].left) unless queue[0].left.nil?
      queue.push(queue[0].right) unless queue[0].right.nil?
      output.push(queue.shift.value)
    end
    return output
  end
  def in_order_iter(node=@root)
    return if node == nil
    stack = []
    output = []
    while true
      if !node.nil?
        stack.push(node)
        node = node.left
      else
        break if stack.empty?
        node = stack.pop
        output << node.value
        node = node.right
      end
    end
    return output
  end
  def in_order(node=@root, output=[])
    # DFS in_order left, root, right
    return if node.nil?
    in_order(node.left, output)
    output << node.value
    in_order(node.right, output)
    return output
  end
  def pre_order(node=@root, output=[])
    # DFS pre_order root, left, right
    return if node.nil?
    output << node.value
    pre_order(node.left, output)
    pre_order(node.right, output)
    return output
  end
  def post_order(node=@root, output=[])
    # DFS post_order left, right, root
    return if node.nil?
    post_order(node.left, output)
    post_order(node.right, output)
    output << node.value
    return output
  end
  def height(node)
    # accepts a node and returns its height
    height = 0
    # height is longest path between the node and a leaf
    level = [node]
    children = []
    until level.empty? && children.empty?
      until level.empty?
        level.each do |level_node|
          children.push(level_node.left) unless level_node.left.nil?
          children.push(level_node.right) unless level_node.right.nil?
        end
        height += 1
        level = children
        children = []
      end
    end
    return height
    # for every node in level add the children (if any) in children
    # when level is clear, if children is not empty, increase height by 1
    # transfer children to level and loop
    # when both level and children are empty stop and return height
  end
  def depth(node)
    # accepts a node and returns its depth
    # depth is the distance between a node and the root
    return nil if node.nil?
    return 0 if node == @root
    cursor = @root
    depth = 1
    until cursor == node
      cursor = (cursor.left.nil? ? nil : cursor.left) if node.value < cursor.value
      cursor = (cursor.right.nil? ? nil : cursor.right) if node.value > cursor.value
      depth += 1
    end
    return depth
  end
  def balanced?(node=@root)
    # check if the tree is balanced.
    # maximum of 1 in difference between height of right and left subtree of every node
    return true if node.nil?
    height_left = node.left.nil? ? 0 : height(node.left)
    height_right = node.right.nil? ? 0 : height(node.right)
    delta = height_left.abs - height_right.abs
    return false if delta.abs > 1
    return true if balanced?(node.left) && balanced?(node.right)
    return false
  end
  def rebalance
    # rebalance an unbalanced tree
    arr = level_order
    @root = build_tree(arr)
  end
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

def simple_driver_script
  # 1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
  #arr = Array.new(15) { rand(1..100) }
  arr = [86, 86, 52, 29, 100, 27, 57, 2, 55, 59, 70, 23, 53, 98, 97]
  p "Building tree with Array: #{arr}"
  my_tree = Tree.new(arr)
  puts ""
  my_tree.pretty_print
  puts ""
  # 2. Confirm that the tree is balanced by calling `#balanced?`
  p "Tree is balanced: #{my_tree.balanced?}"
  # 3. Print out all elements in level, pre, post, and in order
  p "Level order: #{my_tree.level_order}"
  p "Pre order: #{my_tree.pre_order}"
  p "Post order: #{my_tree.post_order}"
  p "In order: #{my_tree.in_order}"
  # 4. try to unbalance the tree by adding several numbers > 100
  p "Inserting values 100 to 104"
  my_tree.insert(100)
  my_tree.insert(101)
  my_tree.insert(102)
  my_tree.insert(103)
  my_tree.insert(104)
  puts ""
  my_tree.pretty_print
  puts ""
  # 5. Confirm that the tree is unbalanced by calling `#balanced?`
  p "Tree is balanced: #{my_tree.balanced?}"
  # 6. Balance the tree by calling `#rebalance`
  p "Rebalancing tree"
  my_tree.rebalance
  puts ""
  my_tree.pretty_print
  puts ""
  # 7. Confirm that the tree is balanced by calling `#balanced?`
  p "Tree is balanced: #{my_tree.balanced?}"
  # 8. Print out all elements in level, pre, post, and in order
  p "Level order: #{my_tree.level_order}"
  p "Pre order: #{my_tree.pre_order}"
  p "Post order: #{my_tree.post_order}"
  p "In order: #{my_tree.in_order}"
  p "Trying to delete value 70"
  my_tree.delete(70)
  puts ""
  my_tree.pretty_print
  puts ""
end 

simple_driver_script