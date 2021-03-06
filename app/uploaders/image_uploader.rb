class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/media/photos/products/default.jpg"
  end

  process resize_to_fit: [800, 800]

  version :thumb do
   process resize_to_fill: [200,200]
  end

  version :medium do
   process resize_to_fill: [400,400]
  end

  protected

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
