class WelcomeController < ApplicationController
  protect_from_forgery except: :download

  def index
  end

  def show
  end

  # def remove_file
  #   return redirect_to root_path
  # end

  def download
    send_file "#{Rails.root}/public/#{session[:file_name]}"
    # DeleteFileJob.perform_later(session[:file_name])
  end

  def upload
    file = params[:file].tempfile
    text = file.read
    file_type = file.path.split(".")[-1]
    file_name = params[:file].original_filename

    if file_type == 'rb' && params['uncomment']
      p "MADE IT"
      content = Remover.uncomment_rb(text)
    elsif file_type == 'rb' && params['unlog']
      content = Remover.unlog_rb(text)
    elsif file_type == 'js' && params['uncomment']
      content = Remover.uncomment_js(text)
    elsif file_type == 'js' && params['unlog']
      content = Remover.unlog_js(text)
    end

    File.new(File.join(Rails.root, 'public', file_name), 'w')
    File.open(File.join(Rails.root, 'public', file_name), 'w') do |f|
      content.each {|line| f.puts line }
    end

    session[:file_name] = file_name
    redirect_to welcome_show_path
  end
end