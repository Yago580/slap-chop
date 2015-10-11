module Remover
  def self.remove_content(pattern, string)
    get_content(patterns[pattern], string)
  end

  def self.get_content(pattern, string)
    string.split("\n").reject {|line| line =~ pattern}
  end

  private
    def self.patterns
      {
        'uncomment_rb' => Regexp.new('#.*'),
        'uncomment_js' => Regexp.new('//.+$'),
        'unlog_rb'     => Regexp.new('(p |print |puts ).*$'),
        'unlog_js'     => Regexp.new('console\.log.+$')
      }
    end
end