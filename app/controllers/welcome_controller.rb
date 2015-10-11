class WelcomeController < ApplicationController
  protect_from_forgery except: :download

  def index
    DeleteFileJob.perform_later
  end

  def upload
    original = params[:file].original_filename
    pathname = Pathname.new(params[:file].tempfile)
    content = accepted_content(pathname.extname, pathname.read)
    
    write_to_file(content, original)
    send_file path_for(original)
  end

  private
    def accepted_content(suffix, text)
      pattern = params['removal_type']+suffix
      Remover.remove_content(pattern, text)
    end

    def write_to_file(content, filename)
      File.new(path_for(filename), 'w')
      File.open(path_for(filename), 'w') do |f|
        content.each {|line| f.puts line }
      end
    end

    def path_for(filename)
      File.join(Rails.root, 'public', filename)
    end
end