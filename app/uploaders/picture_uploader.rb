class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  # storage :file
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  version :thumb do
    cloudinary_transformation format: :png, transformation: [
      {effect: :improve},
      {width: 27, height: 27, crop: :thumb, gravity: :face, radius: :max}
    ]
  end

  version :standard do
    process :resize_to_fill => [800, 500]
  end

  version :circle do
    cloudinary_transformation format: :jpg, transformation: [
      {effect: :improve},
      {width: 150, height: 150, crop: :thumb, gravity: :face, radius: :max}
    ]
  end
end
