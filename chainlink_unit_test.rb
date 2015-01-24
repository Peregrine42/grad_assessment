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
end
