class DeleteFileJob < ActiveJob::Base
  queue_as :default

  def perform(file_name)
    File.delete("#{Rails.root}/public/#{file_name}")
  end
end
