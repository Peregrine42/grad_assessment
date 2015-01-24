class Chainlink

  def initialize(reader, builder)
    @reader  = reader
    @builder = builder
  end
  

  def walk(file_name, start_employee_id, end_employee_id)
    table_as_string = @reader.read(file_name)
    heirarchy       = @builder.build(table_as_string)
  end

end
