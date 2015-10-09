class WelcomeController < ApplicationController
  protect_from_forgery except: :download

  def index
  end

  def show
  end

  def download
    send_file "#{Rails.root}/public/#{session[:file_name]}"
  end

  def upload
    file = params[:file].tempfile
    text = file.read
    file_type = file.path.split(".")[-1]
    file_name = params[:file].original_filename

    if file_type == 'rb'
      content = Remover.uncomment_rb(text)
    elsif file_type == 'js'
      content = Remover.uncomment_js(text)
    end

    File.new(File.join(Rails.root, 'public', file_name), 'w')
    File.open(File.join(Rails.root, 'public', file_name), 'w') do |f|
      content.each {|line| f.puts line }
    end

    session[:file_name] = file_name
    redirect_to welcome_show_path
  end
end