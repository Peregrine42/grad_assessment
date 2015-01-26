class Chainlink

  class Employee

    attr_accessor :id, :name, :manager

    def initialize id, name, manager
      @id = id
      @name = name
      @manager = manager
    end

    def inspect
      "#{name} manager: #{manager}"
    end

    def to_s
      "#{name} (#{id})"
    end

  end

  def build_heirachy array
    employees = array.map do |employee_hash|
      Employee.new employee_hash[:id], employee_hash[:name], employee_hash[:manager_id]
    end
    linked_employees = employees.map do |employee|
      unless employee.manager.nil?
        manager = find_employee_by_id(employee.manager, employees) 
        employee.manager = manager 
      end
      employee
    end
  end

  def initialize(reader, builder)
    @reader  = reader
    @builder = builder
  end

  def walk(file_name, start_employee_name, end_employee_name)
    table_as_string = @reader.read(file_name)
    table_as_array  = @builder.build(table_as_string)

    heirarchy_table = build_heirachy table_as_array
    start_employee = find_employee_by_name start_employee_name, heirarchy_table
    end_employee   = find_employee_by_name end_employee_name,   heirarchy_table

    path_up, path_down = find_path_between_employees start_employee, end_employee, []
    path_down.reverse!
    "#{path_up.join(' -> ')} -> #{path_down.join(' <- ')}"
  end

  def find_path_between_employees start_employee, end_employee, chain
    possible_highest_common_employee = start_employee.manager

    from_end_employee_to_highest_common = path_between(end_employee, possible_highest_common_employee, [])
    return [chain + [start_employee], from_end_employee_to_highest_common] if from_end_employee_to_highest_common
    return nil if possible_highest_common_employee.manager.nil?
    return find_path_between_employees possible_highest_common_employee, end_employee, chain + [start_employee]
  end

  def path_between employee, manager, chain
    return chain + [employee, employee.manager] if manager == employee.manager
    return path_between employee.manager, manager, chain + [employee] unless employee.manager.nil?
  end

end
