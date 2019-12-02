class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :profile, foreign_key: 'match_face_id', primary_key: 'face_id', class_name: 'Profile'
 
end
