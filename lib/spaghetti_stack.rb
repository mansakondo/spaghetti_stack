# frozen_string_literal: true

require_relative "spaghetti_stack/version"

class SpaghettiStack

  class Node
    attr_reader :data, :parent

    def initialize(data, parent = nil)
      @data = data
      @parent = parent
    end

    def update(data)
      return @data if @data.frozen?
      @data = data
    end
  end

  attr_reader :root, :top

  def initialize(data)
    @root = Node.new(data)
    @top = root
  end

  def push(data)
    node = Node.new(data, top)
    @top = node
  end

  alias << push

  def pop
    node   = top
    parent = node.parent

    if parent
      @top = parent
      visited_nodes << node
    end
  end

  def visited_nodes
    @visited_nodes ||= []
  end

  def each
    return self.to_enum unless block_given?

    node = top
    until node == root
      yield node
      node = node.parent
    end
    yield node

    visited_nodes.each { |visited_node| yield visited_node }

    self
  end

  def inspect
    output = ""

    each do |node|
      data = node.data

      if node == root
        output = "(#{data}#{output})"
        return output
      else
        output = " <~ #{data}" + output
      end
    end

    super
  end
end
