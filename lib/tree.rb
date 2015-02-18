class Tree
  attr_reader :parent
  attr_accessor :data, :children

  def initialize(data, parent = nil)
    @data = data
    @parent = parent
    @children = []
  end

  def add(data)
    @children.push(Tree.new(data, self))
  end

  def remove(data)
    tree = traverse_df(data)

    if tree.root?
      tree.data = nil
      tree.children = []
    else
      tree.parent.children.select! { |child| child.object_id != tree.object_id }
    end
  end

  def root?
    @parent.nil?
  end

  def traverse_df(data)
    return self if self.data == data

    if children.any?
      children.each do |child|
        tree = child.traverse_df(data)
        return tree unless tree.nil?
      end
    end
  end
end
