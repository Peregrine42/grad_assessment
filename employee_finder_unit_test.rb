require 'minitest/autorun'
require './employee_finder'

class TestEmployeeFinder < Minitest::Test

  Employee = Struct.new :id, :name

  def setup
    @employee_1 = Employee.new 1, 'bob'
    @employee_2 = Employee.new 2, 'fred'
    @employee_3 = Employee.new 3, 'frank'

    @table = [@employee_1,
              @employee_2,
              @employee_3]

  end

  def test_find_by_id
    assert_equal(@employee_2, EmployeeFinder.new.find_by_id(2, @table))
  end

  def test_find_by_name
    assert_equal(@employee_3, EmployeeFinder.new.find_by_name('frank', @table))
  end
end
