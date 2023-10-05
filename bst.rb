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
        holder_one = root.left
        root = root.right
        root.left = holder_one
      else
        # holder_two = root.
        root.data = root.right.left.data
        root.right.left = nil
      end

      root
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])

tree.build_tree
tree.insert(0)
tree.insert(200)
tree.insert(199)
tree.pretty_print
tree.delete(8)
tree.pretty_print
