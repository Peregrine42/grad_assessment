require './finder'
require './employee'

class BuilderException < StandardError
end

class Builder

  def initialize finder=Finder.new
    @finder = finder
  end

  def build table_string
    lines = table_string.split("\n")
    start_index = find_start_of_table(lines)
    raise BuilderException, 'empty table' if lines[start_index] == nil
    lines = lines[start_index..-1]
    employees = lines.map { |line| Employee.new line }
    employees.map { |employee| link(employee, employees) }
  end

  def find_start_of_table lines
    index = lines.find_index { |line| line.downcase.match /employee id *\| *name *\| *manager id/ }
    if index == nil
      index = 0
    else
      index += 1
    end
  end

  def link employee, employees
    unless employee.manager.nil?
      manager = @finder.find_by_id(employee.manager, employees) 
      employee.manager = manager 
    end
    employee
  end
end
