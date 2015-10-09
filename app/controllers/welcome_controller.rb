class WelcomeController < ApplicationController
  def index

  end

  def show

  end

  def download
    send_file "#{Rails.root}/public/bullshit.rb"
  end

  def upload
    file = params['file'].tempfile
    text = file.read
    content = Remover.uncomment_rb(text)


    File.new(File.join(Rails.root, 'public', 'bullshit.rb'), 'w')
    File.open(File.join(Rails.root, 'public', 'bullshit.rb'), 'w') do |f|
      content.each {|line| f.puts line }
    end
    
    redirect_to welcome_show_path
  end
end