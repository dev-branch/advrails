class UploadImagesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    kid, title, content, link, orig, token, path, content_type, position = args
    Azure::Storage.setup(:storage_account_name => ENV['AZURE_ACCOUNT'], :storage_access_key => ENV['AZURE_KEY'])
    blob = Azure::Storage::Blob::BlobService.new
    binary = ::File.open(path, 'rb'){|file| file.read}
    host = ENV['AZURE_URL']
    relative = "#{token}/#{orig}"
    absolute = "#{host}/#{relative}"
    blob.create_block_blob(ENV['AZURE_CONTAINER'], relative, binary, {content_type: content_type})
    ap Section.create!(klass_id: kid, title: title, content: content, link: link, azure: absolute, position: position)
  end
end
