class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader

  def filename
    "#{user.id}/#{model.randomstring}.#{model.image.file.extension}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
