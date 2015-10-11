module Remover
  def self.remove_content(pattern, string)
    get_content(patterns[pattern], string)
  end

  def self.get_content(pattern, string)
    string.gsub(pattern, "").split("\n")
  end

  private
    def self.patterns
      {
        'uncomment.rb' => Regexp.new('#.*'),
        'uncomment.js' => Regexp.new('//.*$|/\*(.|\s)*\*/'),
        'unlog.rb'     => Regexp.new('(p |print |puts ).*$'),
        'unlog.js'     => Regexp.new('console\.log.+$')
      }
    end
end
