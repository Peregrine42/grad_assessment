require './lib/exception'

class FinderException < ChainlinkException
end

class Finder
  def find_by_id(id, employee_list)
    employee_index = employee_list.find_index { |employee| employee.id == id }
    employee_list[employee_index]
  end

  def find_by_name(name, employee_list)
    result = employee_list.select do |employee|
      employee.name.downcase == name.downcase
    end
    fail FinderException, "#{name} not found" if result.empty?
    result
  end
end
