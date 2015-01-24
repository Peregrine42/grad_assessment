require 'minitest/autorun'
require './chainlink'

class TestChainlink < Minitest::Test

  def test_it_finds_the_chain_of_command_between_two_employees
    expected_result = "Batman (16) -> Black Widow (6) -> Gonzo the Great (2) -> Dangermouse (1) <- Invisible Woman (3) <- Super Ted (15)"
    actual_result   = Chainlink::walk("./fixtures/superheroes.txt", "Batman", "Super Ted")

    assert_equal(expected_result, actual_result)
  end

end
