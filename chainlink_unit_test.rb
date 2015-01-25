require 'minitest/autorun'
require './chainlink'

class TestChainlink < Minitest::Test

  def setup
    @reader  = Minitest::Mock.new
    @reader.expect(:read, "incoming string", args=["a file path"])

    @builder = Minitest::Mock.new
    @builder.expect(:build, :tree, args=["incoming string"])

    @chainlink = Chainlink.new(@reader, @builder)
  end

  def test_it_gets_a_string_from_a_reader
    @chainlink.walk("a file path", "foo", "bar")
    @reader.verify
  end

  def test_it_gets_an_employee_heirachy_from_the_string
    @chainlink.walk("a file path", "foo", "bar")
    @builder.verify
  end

  def test_path_between
    manager  = Chainlink::Employee.new(2, 'pointy ears', nil)
    employee = Chainlink::Employee.new(1, 'bob', manager)

    assert_equal([employee, manager], @chainlink.path_between(employee, manager, []))
  end

  def test_long_path_between
    manager   = Chainlink::Employee.new(3, 'pointy ears', nil)
    middleman = Chainlink::Employee.new(2, 'less pointy ears', manager)
    employee  = Chainlink::Employee.new(1, 'bob', middleman)
    result = @chainlink.path_between(employee, manager, [])
    assert_equal([employee, middleman, manager], result)
  end

  def test_really_long_path_between
    ceo       = Chainlink::Employee.new(6, 'top cat', nil)
    manager   = Chainlink::Employee.new(3, 'pointy ears', ceo)
    middleman = Chainlink::Employee.new(2, 'less pointy ears', manager)
    employee  = Chainlink::Employee.new(1, 'bob', middleman)
    result = @chainlink.path_between(employee, ceo, [])
    assert_equal([employee, middleman, manager, ceo], result)
  end

  def test_no_path_between
    manager   = Chainlink::Employee.new(3, 'pointy ears', nil)
    middleman = Chainlink::Employee.new(2, 'less pointy ears', nil)
    employee  = Chainlink::Employee.new(1, 'bob', middleman)
    result = @chainlink.path_between(employee, manager, [])
    assert_equal(nil, result)
  end
end
