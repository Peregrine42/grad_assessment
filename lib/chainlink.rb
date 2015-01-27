require './lib/reader'
require './lib/builder'
require './lib/finder'
require './lib/walker'
require './lib/joiner'

class ChainlinkException < StandardError
end

class Chainlink
  def initialize(reader = Reader.new,
                 builder = Builder.new,
                 finder = Finder.new,
                 walker = Walker.new,
                 joiner = Joiner.new)
    @reader  = reader
    @builder = builder
    @finder  = finder
    @walker  = walker
    @joiner = joiner
  end

  def walk(file_name, start_employee_name, end_employee_name)
    table_as_string = @reader.read(file_name)
    employees       = @builder.build(table_as_string)

    start_employees = @finder.find_by_name start_employee_name, employees
    end_employees   = @finder.find_by_name end_employee_name,   employees

    fail ChainlinkException, "#{start_employee_name} not found in table" if start_employees.empty?
    fail ChainlinkException, "#{end_employee_name} not found in table" if end_employees.empty?

    start_employees.product(end_employees).map do |start_employee, end_employee|
      chain_up, manager, chain_down = @walker.walk start_employee, end_employee
      @joiner.join(chain_up, manager, chain_down)
    end
  end
end
