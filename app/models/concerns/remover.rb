module Remover
  def self.uncomment_rb(string)
    get_accepted_content(string.split("\n"), Regexp.new('#.*'))
  end

  def self.uncomment_js(string)
    get_accepted_content(string.split("\n"), Regexp.new('//.+$'))
  end

  def self.unlog_rb(string)
    get_accepted_content(string.split("\n"), Regexp.new('(p |print |puts ).*$'))
  end

  def self.unlog_js(string)
    get_accepted_content(string.split("\n"), Regexp.new('console\.log.+$'))
  end

  def self.get_accepted_content(array, regexp)
    array.reject {|line| line  =~ regexp}
  end
end