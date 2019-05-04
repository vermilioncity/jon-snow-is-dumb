class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
