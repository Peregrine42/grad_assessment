require 'minitest/autorun'
require './chainlink'

class TestChainlink < Minitest::Test

  def setup
    @reader  = Minitest::Mock.new
    @builder = Minitest::Mock.new
    @finder  = Minitest::Mock.new
    @walker  = Minitest::Mock.new
    @writer = Minitest::Mock.new
    @chainlink = Chainlink.new(@reader, @builder, @finder, @walker, @writer)

    @reader.expect(:read, "incoming string", args=["a file path"])
    @builder.expect(:build, :table, args=["incoming string"])
    @finder.expect(:find_by_name, [:start_employee], args=["foo", :table])
    @finder.expect(:find_by_name, [:end_employee],   args=["bar", :table])
    @walker.expect(:walk, [:chain_up, :manager, :chain_down], 
                     args=[:start_employee, :end_employee])
    @writer.expect(:join, 'output', 
                     args=[:chain_up, :manager, :chain_down])
  end

  def test_it_delegates_properly
    # note: this test will not show up as an assertion in test output
    #       however, it will fail if Chainlink doesn't delegate properly
    @chainlink.walk("a file path", "foo", "bar")
    @reader.verify
  end

  def test_it_returns_an_array_of_output_from_joiner
    assert_equal(@chainlink.walk("a file path", "foo", "bar"), ['output'])
  end

end
