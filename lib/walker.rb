class Walker
  def walk(start_employee, end_employee)
    path_up, path_down = find_path(start_employee, end_employee)
    common_manager = path_down.pop
    path_down.reverse!
    [path_up, common_manager, path_down]
  end

  def find_path(start_employee, end_employee, chain = [])
    possible_path = path_between(end_employee, start_employee.manager)
    return [chain + [start_employee], possible_path] if possible_path
    return nil if start_employee.manager.ceo?

    chain << start_employee
    find_path(start_employee.manager, end_employee, chain)
  end

  def path_between(employee, manager, chain = [])
    return chain + [employee, employee.manager] if manager == employee.manager
    chain << employee
    return path_between employee.manager, manager, chain unless employee.ceo?
  end
end
