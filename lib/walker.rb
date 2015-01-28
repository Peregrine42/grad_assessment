require './lib/chainlink'

class WalkerException < ChainlinkException
end

class Walker
  def compare(emp1, emp2)
    chain1 = emp1.chain_of_command.reverse
    chain2 = emp2.chain_of_command.reverse

    chain1, chain2 = pad_arrays(chain1, chain2)

    pairs = chain1.zip chain2

    build_chain(pairs)
  end

  private

  def build_chain(pairs)
    grouped_pairs = pairs.group_by { |e1, e2| e1 == e2 }
    validate_pairs grouped_pairs

    managers = grouped_pairs[true]

    chain1, chain2 = grouped_pairs[false].transpose

    manager = managers.last[0]

    chain1 = chain1.reverse.compact
    chain2 = chain2.compact

    [chain1, manager, chain2]
  end

  def validate_pairs(pairs)
    fail WalkerException, 'duplicate employee' if same_employee pairs
    fail WalkerException, 'no path between employees' if no_path pairs
  end

  def same_employee(pairs)
    pairs[false].nil?
  end

  def no_path(pairs)
    pairs[true].nil?
  end

  def pad_arrays(*arrays)
    # fill out each array to be the same length
    max_length = arrays.map(&:length).max
    arrays.map do |array|
      array.fill(0, max_length) { |i| array[i] }
    end
  end
end
