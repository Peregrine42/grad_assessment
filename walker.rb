class Walker

  def walk start_employee, end_employee
    path_up, path_down = find_path_between_employees start_employee, end_employee
    common_manager = path_down.pop
    path_down.reverse!
    [path_up, common_manager, path_down]
  end

  def find_path_between_employees start_employee, end_employee, chain=[]
    possible_highest_common_employee = start_employee.manager

    from_end_employee_to_highest_common = path_between(end_employee, possible_highest_common_employee)
    return [chain + [start_employee], from_end_employee_to_highest_common] if from_end_employee_to_highest_common
    return nil if possible_highest_common_employee.manager.nil?
    return find_path_between_employees possible_highest_common_employee, end_employee, chain + [start_employee]
  end

  def path_between employee, manager, chain=[]
    return chain + [employee, employee.manager] if manager == employee.manager
    return path_between employee.manager, manager, chain + [employee] unless employee.manager.nil?
  end

end
