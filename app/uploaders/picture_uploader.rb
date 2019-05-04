class PictureUploader < CarrierWave::Uploader::Base

  'def filename
    "#{model.id}/avatar.#{model.avatar.file.extension}"
  end'

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}/"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
