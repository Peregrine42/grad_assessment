require './lib/chainlink'
require './lib/employee'

class BuilderException < ChainlinkException
end

class Builder
  def initialize(finder = Finder.new)
    @finder = finder
  end

  def build(table_string)
    lines = table_string.split("\n")
    start_index = find_start_of_table(lines)
    fail BuilderException, 'empty table' if lines[start_index].nil?
    lines = lines[start_index..-1]
    employees = lines.map { |line| Employee.parse line }
    employees.map { |employee| link(employee, employees) }
  end

  def find_start_of_table(lines)
    pattern = /employee id *\| *name *\| *manager id/
    index = lines.find_index { |line| line.downcase.match(pattern) }
    if index.nil?
      index = 0
    else
      index += 1
    end
    index
  end

  def link(employee, employees)
    unless employee.manager.nil?
      manager = @finder.find_by_id(employee.manager, employees)
      employee.manager = manager
    end
    employee
  end
end
