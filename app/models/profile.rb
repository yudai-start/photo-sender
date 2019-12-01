class Profile < ApplicationRecord
  mount_uploader :image, ProfileUploader
end
