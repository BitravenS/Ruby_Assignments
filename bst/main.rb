require_relative 'lib/tree'

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 45, 4, 3, 2, 1, 35, 334, 0])
test.pretty_print

t2 = Tree.new(Array.new(15) { rand(1..100) })
t2.pretty_print
p t2.balanced?
p t2.level_order
p t2.preorder
p t2.inorder
p t2.postorder
t2.insert(101)
t2.insert(107)
t2.pretty_print
p t2.balanced?
t2.rebalance
t2.pretty_print
p t2.balanced?
