class WelcomeController < ApplicationController
  protect_from_forgery except: :download

  def index
    DeleteFileJob.perform_later # get rid of uploaded files
  end

  def upload
    filename = params[:file].original_filename
    pathname = Pathname.new(params[:file].tempfile)
    results  = filter_content(pathname.extname, pathname.read)
    
    write_to_file(results, filename)
    send_file path_for(filename)
  end

  private
    def filter_content(suffix, text)
      pattern = params['removal_type']+suffix
      Remover.remove_content(pattern, text)
    end

    def write_to_file(text, filename)
      File.new(path_for(filename), 'w')
      File.open(path_for(filename), 'w') do |f|
        text.each {|line| f.puts line }
      end
    end

    def path_for(filename)
      File.join(Rails.root, 'public', filename)
    end
end