require './lib/chainlink'

class WalkerException < ChainlinkException
end

class Walker
  def walk(start_employee, end_employee)
    path_up, path_down = find_path(start_employee, end_employee)
    common_manager = path_down.pop
    path_down.reverse!
    [path_up, common_manager, path_down]
  end

  def find_path(start_employee, end_employee, chain = [])
    possible_path = path_between(end_employee, start_employee.manager)
    return [chain + [start_employee], possible_path] if possible_path
    return nil if start_employee.manager.ceo?

    chain << start_employee
    find_path(start_employee.manager, end_employee, chain)
  end

  def path_between(employee, manager, chain = [])
    return chain + [employee, employee.manager] if manager == employee.manager
    chain << employee
    return path_between employee.manager, manager, chain unless employee.ceo?
  end

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

    def initialize combined_chains
      @pairs = combined_chains.group_by { |e1, e2| e1 == e2 }

      chain1, chain2 = @pairs[false].transpose
      
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
      managers = @pairs[true]
      fail WalkerException, 'no path between employees' if managers.nil?
      managers.last[0]
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
