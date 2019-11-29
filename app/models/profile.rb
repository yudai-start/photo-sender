class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader
end
