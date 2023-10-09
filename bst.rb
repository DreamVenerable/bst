class Node
  attr_accessor :left, :right, :data

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  def initialize(arr, root = nil)
    @arr = arr
    clean_arr
    @root = root
    @end_i = arr.length - 1
  end

  def clean_arr
    @arr.uniq! unless @arr.uniq.length == @arr.length
    @arr.sort!
  end

  def build_tree(arr = @arr, s = 0, e = @end_i)
    return nil if s > e

    mid = (s + e) / 2

    @root = Node.new(arr[mid], build_tree(arr, s, mid - 1), build_tree(arr, mid + 1, e))
    @root
  end

  def insert(root = @root, data)
    root = Node.new(data) if root.nil?
    root if root.data == data
    root.left = insert(root.left, data) if root.data > data
    root.right = insert(root.right, data) if root.data < data
    root
  end

  def delete(root = @root, data)
    return root if root.nil?

    if root.data > data
      root.left = delete(root.left, data) 
      return root
    elsif root.data < data
      root.right = delete(root.right, data) 
      return root
    end

    if root.left.nil? && root.right.nil?
      root = nil if root.data == data
    elsif root.left.nil?
      root = root.right
    elsif root.right.nil?
      root = root.left
    else

      if root.right.left.nil?
        holder = root.right.data
        delete(holder)
        root.data = holder
      else
        temp = root.right

        while temp.left != nil
          temp = temp.left
        end

        holder = temp.data
        delete(holder)
        root.data = holder
      end
      root
    end
  end

  def find(root = @root, value)
    return root if root.nil? || root.data == value
    root.data > value ? find(root.left, value) : find(root.right, value)
  end

  def level_order
    queue = []
    arr = []
    position = @root
    queue.push(position)

    until queue.empty?
      position = queue[0]
      arr.push(queue[0].data)
      queue.shift
      queue.push(position.left) unless position.left.nil?
      queue.push(position.right) unless position.right.nil?
    end

    arr
  end

  def inorder(root = @root, arr = [])
    return root if root.nil?

    inorder(root.left, arr)
    arr.push(root.data)
    inorder(root.right, arr)

    arr
  end

  def preorder(root = @root, arr = [])
    return root if root.nil?

    arr.push(root.data)
    preorder(root.left, arr)
    preorder(root.right, arr)

    arr
  end

  def postorder(root = @root, arr = [])
    return root if root.nil?

    postorder(root.left, arr)
    postorder(root.right, arr)
    arr.push(root.data)

    arr
  end

  def height(node = @root, counter = -2)
    return counter if node.nil?

    counter += 1
    [height(node.left, counter), height(node.right, counter)].max
  end

  def depth(node)
    return nil if node.nil?

    current_node = @root
    counter = 0

    until current_node.data == node.data
      counter += 1
      current_node = current_node.left if node.data < current_node.data
      current_node = current_node.right if node.data > current_node.data
    end

    counter
  end

  def balanced?
    left = height(@root.left)
    right = height(@root.right)
    (right - left).between?(-1, 1)
  end

  def rebalance
    @arr = inorder
    end_i = @arr.length - 1
    @root = build_tree(@arr, 0, end_i)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end



arr = Array.new(15) { rand(1..100) }
tree = Tree.new(arr)
puts "Tree created!"
sleep 0.5

tree.build_tree
puts "Building tree..."
sleep 0.5

tree.pretty_print
sleep 0.5

puts "Tree balanced?"
sleep 0.5
p tree.balanced?
sleep 0.5

puts "Printing trees on order type..."
sleep 0.5

puts "Level Order:"
sleep 0.5
p tree.level_order
sleep 0.5

puts "Preorder:"
sleep 0.5
p tree.preorder
sleep 0.5

puts "Postorder:"
sleep 0.5
p tree.postorder
sleep 0.5

puts "Inorder:"
sleep 0.5
p tree.inorder
sleep 0.5

puts 'To randomly add numbers over 100 to the tree, press any key '
STDIN.getc
repeat = rand(5..10)
repeat.times do
  add = rand(100..500)
  puts "Adding #{add}..."
  tree.insert(add)
  sleep 0.5
end

puts "Current Tree:"
sleep 0.5
tree.pretty_print
sleep 0.5

puts "Tree balanced?"
sleep 0.5
p tree.balanced?
sleep 0.5

puts "Rebalancing..."
tree.rebalance
sleep 0.5

puts "Current Tree:"
sleep 0.5
tree.pretty_print
sleep 0.5

puts "Tree balanced?"
sleep 0.5
p tree.balanced?
sleep 0.5

puts "Printing trees on order type..."
sleep 0.5

puts "Level Order:"
sleep 0.5
p tree.level_order
sleep 0.5

puts "Preorder:"
sleep 0.5
p tree.preorder
sleep 0.5

puts "Postorder:"
sleep 0.5
p tree.postorder
sleep 0.5

puts "Inorder:"
sleep 0.5
p tree.inorder
sleep 0.5
