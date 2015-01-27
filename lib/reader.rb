class Reader
  def read(file_name)
    File.open(file_name, 'rb') do |file|
      @contents = file.read
    end
    @contents
  end
end
