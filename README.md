# SpaghettiStack

This is a Ruby implementation of a [SpaghettiStack](https://en.wikipedia.org/wiki/Parent_pointer_tree)(also called *parent pointer tree* or *cactus stack*). A SpaghettiStack can be thought as a linked list where each element (call nodes) keeps a reference pointing to their parent (possibly null), but not to their children. This means that a node can only access to it's parent, but not it's children. 
Another particularity of this kind of stack is that when nodes are popped, they're kept in-memory instead of being destroyed, thus preserving the link to their parent. That's why this data structure is used by compilers to create symbol tables for each lexical scopes, because it allows them to revisit previous scopes to resolve references.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spaghetti_stack'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install spaghetti_stack

## Usage

```ruby
require "spaghetti_stack"

scopes = SpaghettiStack.new(:class)

p scopes.root.data == :class # => true

scopes.push(:def)
scopes.push(:block)
p scopes.top.data == :block # => true

p scopes # => (class <~ def <~ block)

scopes.pop
scopes.pop
p scopes.root == scopes.top # => true

p scopes.visited_nodes.map(&:data) # => [:block, :def]
p scopes # => (class)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spaghetti_stack.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
