class WelcomeController < ApplicationController
  protect_from_forgery except: :download

  def index
  end

  def show
  end

  def download
    p @file_name = session['file_name']
    send_file "#{Rails.root}/public/#{@file_name}"
  end

  def upload
    file = params['file'].tempfile
    text = file.read
    file_type = file.path.split(".")[-1]

    if file_type == 'rb'
      content = Remover.uncomment_rb(text)
    elsif file_type == 'js'
      content = Remover.uncomment_js(text)
    end

    File.new(File.join(Rails.root, 'public', 'bullshit.'+file_type), 'w')
    File.open(File.join(Rails.root, 'public', 'bullshit.'+file_type), 'w') do |f|
      content.each {|line| f.puts line }
    end

    session['file_name'] = 'bullshit.'+file_type
    redirect_to welcome_show_path
  end
end