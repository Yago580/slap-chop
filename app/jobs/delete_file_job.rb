class DeleteFileJob < ActiveJob::Base
  queue_as :default

  def perform
    Dir.glob(File.join(Rails.root, 'public', '*.{rb,js}')).each { |f| File.delete(f) }
  end
end
