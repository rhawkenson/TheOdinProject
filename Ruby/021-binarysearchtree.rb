class Node
  attr_accessor :left, :right, :data
  def initialize(data)
    @left = nil
    @right = nil
    @data = data
  end
  # try including the Comparable module
end

class Tree
  attr_accessor :root, :right, :left
  def initialize(arr)
    @root = build_tree(arr)
  end
  def build_tree(arr)
    return nil unless arr.last
    arr = arr.uniq.sort
    root = Node.new(arr[(arr.length)/2])
    root.left = build_tree(arr[0, arr.length/2])
    root.right = build_tree(arr[arr.length/2+1, arr.length])
    return root
  end
  def insert(value, node=@root)
    value = value.to_i
    # only adding if > or < so if its == its ignored by default
    if value < node.data
      node.left == nil ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.data
      node.right == nil ? node.right = Node.new(value) : insert(value, node.right)
    end
  end
  def delete(value)
    # check nodes until finding the parent of the node to delete
    # until (node.left.nil? ? nil : node.left.data) == value or (node.right.nil? ? nil : node.right.data) == value
    #   node = node.left if value < node.data
    #   node = node.right if value > node.data
    #   return "not found" if node.left == nil and node.right == nil
    # end
    node = @root
    node_delete, found, side, parent = nil

    until found
      if @root.data == value
        parent = nil
        node_delete = @root
        found = true
      elsif (node.left.nil? ? nil : node.left.data) == value
        side = "left"
        parent = node
        node_delete = parent.left
        found = true
      elsif (node.right.nil? ? nil : node.right.data) == value
        side = "right"
        parent = node
        node_delete = parent.right
        found = true
      elsif value < node.data && !node.left.nil?
        node = node.left
      elsif value > node.data && !node.right.nil?
        node = node.right
      else
        return "Not found"
      end
    end

    # if node_delete had no left or right children then parent.side = nil
    if node_delete.left == nil && node_delete.right == nil
      if parent.nil?
        @root = nil
      elsif side == "left"
        parent.left = nil
      else
        parent.right = nil
      end

    # if node_delete had only children on the left side
    elsif node_delete.right == nil
      if parent.nil?
        @root = node_delete.left
      elsif side == "left"
        parent.left = node_delete.left
      else
        parent.right = node_delete.left
      end

    # if node_delete had only children on the right side
    elsif node_delete.left == nil
      if parent.nil?
        @root = node_delete.right
      elsif side == "left"
        parent.left = node_delete.right
      else
        parent.right = node_delete.right
      end

    # if node_delete had left and right children
      # then parent.side = smallest
      # and smallest = node_delete.right.leftest
    else
      # take the smallest in right subtree
      smallest = node_delete.right
      smallest_parent = nil
      until smallest.left.nil?
        smallest_parent = smallest
        smallest = smallest.left
      end
      # at this point we have the smallest and its parent
      # if there was only one node to the right then smallest_parent is nil
      # if smallest_parent is not nil and smallest.right is not nil
      # then smallest_parent.left = smallest.right
      unless smallest_parent.nil?
        if smallest.right.nil?
          smallest_parent.left = nil
        else
          smallest_parent.left = smallest.right
        end
      end
      # then we need to give the smallest node the left and right branches of node_delete
      smallest.left = node_delete.left
      smallest.right = node_delete.right
      # finally we need to give the parent node of node_delete the address of smallest
      if parent.nil?
        @root = smallest
      elsif side == "left"
        parent.left = smallest
      else
        parent.right = smallest
      end
    end
  end
  def find(value)
    # find a value and return the Node with this value
    node = @root
    found = nil
    until found
      if @root.data == value
        found = true
      elsif (node.left.nil? ? nil : node.left.data) == value
        node = node.left
        found = true
      elsif (node.right.nil? ? nil : node.right.data) == value
        node = node.right
        found = true
      elsif value < node.data && !node.left.nil?
        node = node.left
      elsif value > node.data && !node.right.nil?
        node = node.right
      else
        return "Not found"
      end
    end
    return node
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
      output.push(queue.shift.data)
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
        output << node.data
        node = node.right
      end
    end
    return output
  end
  def in_order(node=@root, output=[])
    # DFS in_order left, root, right
    return if node.nil?
    in_order(node.left, output)
    output << node.data
    in_order(node.right, output)
    return output
  end
  def pre_order(node=@root, output=[])
    # DFS pre_order root, left, right
    return if node.nil?
    output << node.data
    pre_order(node.left, output)
    pre_order(node.right, output)
    return output
  end
  def post_order(node=@root, output=[])
    # DFS post_order left, right, root
    return if node.nil?
    post_order(node.left, output)
    post_order(node.right, output)
    output << node.data
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
      cursor = (cursor.left.nil? ? nil : cursor.left) if node.data < cursor.data
      cursor = (cursor.right.nil? ? nil : cursor.right) if node.data > cursor.data
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
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

def simple_driver_script
  # 1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
  arr = Array.new(15) { rand(1..100) }
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
end

simple_driver_script