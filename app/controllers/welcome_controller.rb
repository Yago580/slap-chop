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

    content = accepted_content(file_type, text)
    write_to_file(content, file_name)

    session[:file_name] = file_name
    redirect_to welcome_show_path
  end

  private
    def accepted_content(suffix, text)
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

    def write_to_file(content, filename)
      File.new(File.join(Rails.root, 'public', filename), 'w')
      File.open(File.join(Rails.root, 'public', filename), 'w') do |f|
        content.each {|line| f.puts line }
      end
    end
end