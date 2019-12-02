class Profile < ApplicationRecord
  mount_uploader :image, ProfileUploader
  has_many :posts, foreign_key: 'face_id', primary_key: 'match_face_id', class_name: 'Post'
end
