require './lib/chainlink'

class WalkerException < ChainlinkException
end

class Walker
  def compare(emp1, emp2)
    # start from the ceo, working to each employee
    chain1 = emp1.chain_of_command.reverse
    chain2 = emp2.chain_of_command.reverse

    chain1, chain2 = pad_arrays(chain1, chain2)

    # zip the two arrays together
    combined = chain1.zip chain2

    pairs = ChainComparison.new(combined)

    # compact to remove any trailing nils
    [pairs.chain1, pairs.manager, pairs.chain2]
  end

  private

  class ChainComparison
    attr_reader :chain1, :chain2

    def initialize(pairs)
      grouped_pairs = pairs.group_by { |e1, e2| e1 == e2 }
      fail WalkerException, 'no path between the same employee' if grouped_pairs[false].nil?

      fail WalkerException, 'no path between employees' if grouped_pairs[true].nil?
      @managers = grouped_pairs[true]

      chain1, chain2 = grouped_pairs[false].transpose

      # have chain one start with the employee
      # (chain2 already ends with the employee)
      # compact is used to get rid of trailing nils
      # caused by uneven chains
      @chain1 = chain1.reverse.compact
      @chain2 = chain2.compact
    end

    def manager
      # the highest common manager is the last in the identical pairs
      # if we can't find a common manager, that's an error
      @managers.last[0]
    end
  end

  def pad_arrays(*arrays)
    # fill out each array to be the same length
    max_length = arrays.map(&:length).max
    arrays.map do |array|
      array.fill(0, max_length) { |i| array[i] }
    end
  end
end
