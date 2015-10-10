class WelcomeController < ApplicationController
  protect_from_forgery except: :download

  def index
    DeleteFileJob.perform_later
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

    content = removal_type(file_type, text)

    File.new(File.join(Rails.root, 'public', file_name), 'w')
    File.open(File.join(Rails.root, 'public', file_name), 'w') do |f|
      content.each {|line| f.puts line }
    end

    session[:file_name] = file_name
    redirect_to welcome_show_path
  end

  private
    def removal_type(suffix, text)
      if suffix == 'rb' && params['uncomment']
        return Remover.uncomment_rb(text)
      elsif suffix == 'rb' && params['unlog']
        return Remover.unlog_rb(text)
      elsif suffix == 'js' && params['uncomment']
        return Remover.uncomment_js(text)
      elsif suffix == 'js' && params['unlog']
        return Remover.unlog_js(text)
      end
    end
end