class Remove
  def initialize(file)
    @file     = file
    @filename = file.split('.')[-2]
    @suffix   = file.split('.')[-1]
  end

  def uncomment_rb
    # write_to_file(get_accepted_content(Regexp.new('#.*')))
    p get_accepted_content(Regexp.new('#.*'))
  end

  def uncomment_js
    write_to_file(get_accepted_content(Regexp.new('//.+$')))
  end
  
  def unlog_rb
    write_to_file(get_accepted_content(Regexp.new('(p |print |puts ).+$')))
  end

  def unlog_js
    write_to_file(get_accepted_content(Regexp.new('console\.log.+$')))
  end


  private
    # def get_accepted_content(regexp)

    # end

    def get_accepted_content(regexp)
      File.readlines(@file).reject {|line| line =~ regexp}
    end

    def write_to_file(content)
      File.open(@file, 'w') {|f| content.each {|line| f.puts line}}
    end
end