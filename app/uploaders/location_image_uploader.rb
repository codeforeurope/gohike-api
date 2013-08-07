# encoding: utf-8

class LocationImageUploader < CarrierWave::Uploader::Base

  before :store, :capture_md5

  after :store, :persist_md5

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :fog


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  # Process files as they are uploaded:
  process :resize_to_limit => [800, 800]


  version :mobile do
    process :crop_mobile
    resize_to_fill(570, 380)
  end

  version :icon do
    process :crop_icon
    resize_to_fill(200, 200)
  end

  def crop_mobile
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop([w, 'x', h, '+', x, '+', y].join(''))
        img
      end
    end
  end

  def crop_icon
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop([w, 'x', h, '+', x, '+', y].join(''))
        img
      end
    end
  end

  def capture_md5(args)
    versions.each do |version, u|
      if model.crop_x.present? || (model.send("#{mounted_as}_changed?") && !model.send("#{mounted_as}_#{version}_md5_changed?"))
        model.send "#{mounted_as}_#{version}_md5=", Digest::MD5.file(Rails.public_path + u.url).hexdigest
      end
    end
  end

  def persist_md5(args)
    if versions.present?
      model.crop_x = nil
      model.save
    end
  end

end
