class LinkedList
  #here the full list

  attr_accessor :name

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    # adds a new node containing value to the end of the list
    my_node = Node.new(value)
    if @head == nil
      @head = my_node
      @tail = my_node
    else
      @tail.next_node = my_node
      @tail = my_node
    end
  end

  def prepend(value)
    # adds a new node containing value to the start of the list
    my_node = Node.new(value)
    if @head == nil
      @head = my_node
      @tail = my_node
    else
      my_node.next_node = @head
      @head = my_node
    end
  end

  def size
    # return the total number of nodes in the list
    cursor = @head
    counter = 0
    while cursor != nil
      cursor = cursor.next_node
      counter += 1
    end
    return counter
  end

  def head
    # return the first node in the list
    return @head
  end

  def tail
    # return the last node in the list
    return @tail
  end

  def at(index)
    # return the node at the given index
    cursor = @head
    cursor_index = 0
    until cursor_index == index || cursor == nil
      cursor = cursor.next_node
      cursor_index += 1
    end
    return cursor
  end

  def pop
    # remove the last element from the list
    @tail = at(size - 2)
    @tail.next_node = nil
  end
  
  def contains?(value)
    # return true if the passed in value is in the list and otherwise false
    cursor = @head
    until cursor == nil
      return true if cursor.value == value
      cursor = cursor.next_node
    end
    return false
  end

  def find(value)
    # return the index of the node containing value or nil if not found
    cursor = @head
    cursor_index = 0
    until cursor == nil
      if cursor.value == value
        return cursor_index
      end
      cursor = cursor.next_node
      cursor_index += 1
    end
    return nil
  end
  
  def to_s
    # represent the LinkedList objects as strings to print them
    # format should be ( value ) -> ( value ) -> ( value ) -> nil
    cursor = @head
    until cursor == nil
      print "( #{cursor.value} ) -> "
      cursor = cursor.next_node
    end
    puts "nil"
  end

  def insert_at(value, index)
    # insert the node with the provided value at the given index
    my_node = Node.new(value)
    if index.between?(1, size - 2)
      tmp = at(index)
      index > 0 ? at(index - 1).next_node = my_node : @head = my_node
      my_node.next_node = tmp
    elsif index == 0
      my_node.next_node = @head
      @head = my_node
    elsif index == size - 1
      @tail.next_node = my_node
      @tail = my_node
    end
  end

  def remove_at(index)
    # remove the node at the given index
    if index.between?(1, size - 2)
      at(index - 1).next_node = at(index).next_node
    elsif index == 0
      @head = at(index).next_node unless @head.nil?
    elsif index == size - 1
      @tail = at(index - 1)
      @tail.next_node = nil
    end
  end

end

class Node
  # contains a value method
  # and a link to the #next_node
  # both should be nil by default

  attr_accessor :next_node, :value

  def initialize(value)
    @next_node = nil
    @value = value
  end
end


CHOICES = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

def user_interface
  quit = false
  my_list = LinkedList.new
  until quit == true
    puts "What would you like to do ?"
    puts " [0] Exit program"
    puts " [1] append"
    puts " [2] prepend"
    puts " [3] size"
    puts " [4] head"
    puts " [5] tail"
    puts " [6] at(index)"
    puts " [7] pop"
    puts " [8] contains?"
    puts " [9] find"
    puts " [10] to_s"
    puts " [11] insert_at"
    puts " [12] remove_at"
    print "> "
    choice = ""

    until CHOICES.include? choice
      choice = gets.chomp.to_i
    end

    case choice
    when 0
      quit = true
    when 1
      puts "What is the value to append?"
      print "> "
      value = gets.chomp
      my_list.append(value)
    when 2
      puts "What is the value to prepend?"
      print "> "
      value = gets.chomp
      my_list.prepend(value)
    when 3
      puts my_list.size
    when 4
      puts my_list.head
    when 5
      puts my_list.tail
    when 6
      puts "What is the index to look at?"
      print "> "
      index = gets.chomp.to_i
      puts my_list.at(index)
    when 7
      my_list.pop
    when 8
      puts "What value to check if the LinkedList contains?"
      print "> "
      value = gets.chomp
      puts my_list.contains?(value)
    when 9
      puts "What value to find?"
      print "> "
      value = gets.chomp
      puts my_list.find(value)
    when 10
      my_list.to_s
    when 11
      puts "What value to insert?"
      print "> "
      value = gets.chomp
      puts "What index to insert at?"
      print "> "
      index = gets.chomp.to_i
      my_list.insert_at(value, index)
    when 12
      puts "What index to remove at?"
      print "> "
      index = gets.chomp.to_i
      my_list.remove_at(index)
    end
  end
end

user_interface()