module Remover
  def self.remove_content(pattern, string)
    filter_content(patterns[pattern], string)
  end

  def self.filter_content(pattern, string)
    string.gsub(pattern, "").split("\n")
  end

  private
    def self.patterns
      {
        'uncomment.rb' => Regexp.new('#.*$|^=begin(.|\s)*^=end'),
        'uncomment.js' => Regexp.new('//.*$|/\*(.|\s)*\*/'),
        'unlog.rb'     => Regexp.new('(p |print |puts ).*$'),
        'unlog.js'     => Regexp.new('console\.log\(.*\); ?')
      }
    end
end