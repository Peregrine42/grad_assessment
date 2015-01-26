require 'minitest/autorun'
require './walker'

class TestWalker < Minitest::Test

  Employee = Struct.new :id, :manager

  def test_path_between
    manager  = Employee.new(2, nil)
    employee = Employee.new(1, manager)

    assert_equal([employee, manager], Walker.new.path_between(employee, manager))
  end

  def test_long_path_between
    manager   = Employee.new(3, nil)
    middleman = Employee.new(2, manager)
    employee  = Employee.new(1, middleman)
    result = Walker.new.path_between(employee, manager)
    assert_equal([employee, middleman, manager], result)
  end

  def test_really_long_path_between
    ceo       = Employee.new(6, nil)
    manager   = Employee.new(3, ceo)
    middleman = Employee.new(2, manager)
    employee  = Employee.new(1, middleman)
    result = Walker.new.path_between(employee, ceo)
    assert_equal([employee, middleman, manager, ceo], result)
  end

  def test_no_path_between
    manager   = Employee.new(3, nil)
    middleman = Employee.new(2, nil)
    employee  = Employee.new(1, middleman)
    result = Walker.new.path_between(employee, manager)
    assert_equal(nil, result)
  end
end
