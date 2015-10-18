# Using Slap Chop

#### Remove comments from your code!
Visit [slap-chop](https://slap-chop.herokuapp.com) and upload a ruby or js file. Select the **uncomment** option and Slap Chop will *chop* (see what I did there) all of the file's comments and send you back a brand spanking new comment free file.

#### Remove logs from your code!
But there's more. If you select the **unlog** option, Slap Chop will remove all log statements from the uploaded file. Ruby (p, puts, print), JS (console.log).


# Contributing to Slap Chop

Slap Chop currently supports uncommenting and unlogging for Ruby and JavaScript files, but I would love to add functionality for other languages!

#### Adding regexps
If you would like to add a regular expression for removing comments/logs from files of a different language, open up `app/controllers/concerns/remover.rb` and add the corresponding regexp to the `patterns` module method. In order for the app to select the proper algorithm, keys of the pattern hash must follow the convention of `<action>.<extension>` i.e., `uncomment.rb`

#### An example of an added regexp
```ruby
  # app/controllers/concerns/remover.rb
  
  def self.patterns
    {
      'uncomment.rb' => Regexp.new('#.*$|^=begin(.|\s)*^=end'),
      'uncomment.js' => Regexp.new('//.*$|/\*(.|\s)*\*/'),
      'unlog.rb'     => Regexp.new('(p |print |puts ).*$'),
      'unlog.js'     => Regexp.new('console\.log\(.*\); ?')
      #c++
      'unlog.cpp'    => Regexp.new('<corresponding regexp here>')
    }
  end
```




