class Builder

  def build table_string
    lines = table_string.split("\n")
    start_index = find_start_of_table(lines)
    lines = lines[start_index+1..-1]
    lines.map { |line| extract_line(line) }
  end

  def extract_line line
    match_data = line.match /(\w+) *\| *([\w ]+\w) *\| *(\w+)?/
    fail 'invalid table line' if match_data.nil?
    id         = match_data[1].to_i
    name       = match_data[2]
    manager_id = match_data[3].to_i unless match_data[3].nil?
    {id: id, name: name, manager_id: manager_id }
  end

  def find_start_of_table lines
    index = lines.find_index { |line| line.downcase.match /employee id *\| *name *\| *manager id/ }
    fail 'no table header' if index.nil?
    index
  end

end
