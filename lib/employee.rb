require './lib/chainlink'

class EmployeeException < ChainlinkException
end

class Employee
  attr_accessor :id, :name, :manager

  def self.parse(line)
    match_data = line.match(/(\w+) *\| *([\w \-\.]+\w) *\| *(\w+)?/)
    fail EmployeeException, 'invalid table line' if match_data.nil?
    id      = match_data[1].to_i
    name    = compact(match_data[2])
    manager = match_data[3].to_i unless match_data[3].nil?
    new id, name, manager
  end

  def initialize(id, name, manager)
    @id = id
    @name = name
    @manager = manager
  end

  def inspect
    to_s
  end

  def to_s
    "#{name} (#{id})"
  end

  def self.compact(string)
    string.split(/ +/).join(' ')
  end

  def ceo?
    manager.nil?
  end

  def chain_of_command(chain = [])
    chain << self
    return chain if ceo?
    manager.chain_of_command chain
  end
end
