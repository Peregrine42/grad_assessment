require 'minitest/autorun'
require './lib/chainlink'

class TestWalker < Minitest::Test
  def test_comparing
    ceo        = Employee.new(1, 'ceo', nil)
    manager    = Employee.new(2, 'manager', ceo)
    middleman1 = Employee.new(3, 'm1', manager)
    middleman2 = Employee.new(4, 'm2', manager)
    employee1  = Employee.new(5, 'emp1', middleman1)
    employee2  = Employee.new(6, 'emp2', middleman2)

    up, common_manager, down = Walker.new.compare employee1, employee2
    assert_equal([employee1, middleman1], up)
    assert_equal(manager, common_manager)
    assert_equal([middleman2, employee2], down)
  end

  def test_comparing_uneven_chains
    ceo        = Employee.new(1, 'ceo', nil)
    middleman  = Employee.new(4, 'middle', ceo)
    employee1  = Employee.new(5, 'emp1', ceo)
    employee2  = Employee.new(6, 'emp2', middleman)

    up, common_manager, down = Walker.new.compare employee1, employee2
    assert_equal([employee1], up)
    assert_equal(ceo, common_manager)
    assert_equal([middleman, employee2], down)
  end

  def test_comparing_chains_with_no_common_pairs
    ceo        = Employee.new(1, 'ceo', nil)
    manager    = Employee.new(2, 'manager', ceo)
    middleman1 = Employee.new(3, 'm1', nil)
    middleman2 = Employee.new(4, 'm2', manager)
    employee1  = Employee.new(5, 'emp1', middleman1)
    employee2  = Employee.new(6, 'emp2', middleman2)

    assert_raises(WalkerException) { Walker.new.compare employee1, employee2 }
  end
end
