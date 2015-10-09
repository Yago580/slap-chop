module Remover
  def self.uncomment_rb(string)
    get_accepted_content(string.split("\n"), Regexp.new('#.*'))
  end

  def self.get_accepted_content(array, regexp)
    array.reject {|line| line  =~ regexp}
  end

  # def uncomment_js
  #   write_to_file(get_accepted_content(Regexp.new('//.+$')))
  # end
  
  # def unlog_rb
  #   write_to_file(get_accepted_content(Regexp.new('(p |print |puts ).+$')))
  # end

  # def unlog_js
  #   write_to_file(get_accepted_content(Regexp.new('console\.log.+$')))
  # end


  # private
  #   # def get_accepted_content(regexp)

  #   # end


  #   def write_to_file(content)
  #     File.open(@file, 'w') {|f| content.each {|line| f.puts line}}
  #   end
end