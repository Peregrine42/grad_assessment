class Employee

  attr_accessor :id, :name, :manager

  def initialize id, name, manager
    @id = id
    @name = name
    @manager = manager
  end

  def initialize line
    match_data = line.match /(\w+) *\| *([\w -]+\w) *\| *(\w+)?/
    fail 'invalid table line' if match_data.nil?
    @id      = match_data[1].to_i
    @name    = compact(match_data[2])
    @manager = match_data[3].to_i unless match_data[3].nil?
  end

  def inspect
    "#{name} manager: #{manager}"
  end

  def to_s
    "#{name} (#{id})"
  end

  private
  def compact string
    string.split(/ +/).join(' ')
  end
end
