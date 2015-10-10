module Remover
  def self.uncomment_rb(string)
    get_content(string, '#.*')
  end

  def self.uncomment_js(string)
    get_content(string, '//.+$')
  end

  def self.unlog_rb(string)
    get_content(string, '(p |print |puts ).*$')
  end

  def self.unlog_js(string)
    get_content(string, 'console\.log.+$')
  end

  def self.get_content(string, regexp)
    string.split("\n").reject {|line| line =~ Regexp.new(regexp)}
  end
end