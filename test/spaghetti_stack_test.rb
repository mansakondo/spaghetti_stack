# frozen_string_literal: true

require "test_helper"

class SpaghettiStackTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SpaghettiStack::VERSION
  end

  def test_it_does_something_useful
    scopes = SpaghettiStack.new(:class)

    assert_equal :class, scopes.root.data

    scopes.push(:def)
    scopes.push(:block)
    assert_equal :block, scopes.top.data

    scopes.pop
    scopes.pop
    assert_equal true, scopes.root == scopes.top

    assert_equal [:block, :def], scopes.visited_nodes.map(&:data)

    scopes.top.update :module
    assert_equal :module, scopes.top.data
  end
end
