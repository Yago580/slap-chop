# Using Slap Chop

#### Remove comments from your code!
Visit [slap-chop](https://slap-chop.herokuapp.com) and upload a ruby or js file. Select the **uncomment** option and Slap Chop will *chop* (see what I did there) all of the file's comments and send you back a brand spanking new comment free file.

#### Remove logs from your code!
But there's more. If you select the **unlog** option, Slap Chop will remove all log statements from the uploaded file. in ruby `p, puts, print`, in js `console.log `.


# Contributing to Slap Chop

#### Adding regexps
If you would like to add a regular expression for removing comments/logs from files of a different language, regexps can be added to `Remover.patterns` in `app/controllers/concerns/remover.rb`. In order to select the proper algorithm, keys of the patterns hash must follow the convention of `<action>.<extension>` i.e., `uncomment.rb`

#### An example of an added regexp
```ruby
  # app/controllers/concerns/remover.rb
  
  def self.patterns
    {
      'uncomment.rb' => Regexp.new('#.*$|^=begin(.|\s)*^=end'),
      'uncomment.js' => Regexp.new('//.*$|/\*(.|\s)*\*/'),
      'unlog.rb'     => Regexp.new('(p |print |puts ).*$'),
      'unlog.js'     => Regexp.new('console\.log\(.*\); ?'),
      #c++
      'unlog.cpp'    => Regexp.new('<corresponding regexp here>')
    }
  end
```

#### Stretch
It would be amazing to be able to upload a rails project directory and remove all comments/logs from all its .rb and .js files. I have been able to zip and unzip uploaded directories but am having trouble figuring out how deal with zipping nested directories. It would be great to figure this out.




