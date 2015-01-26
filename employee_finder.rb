class EmployeeFinder

  def find_by_id id, employee_list
    employee_index = employee_list.find_index { |employee| employee.id == id }
    employee_list[employee_index]
  end

  def find_by_name name, employee_list
    employee_index = employee_list.find_index { |employee| employee.name == name }
    employee_list[employee_index]
  end

end
