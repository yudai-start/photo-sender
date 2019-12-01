class Profile < ApplicationRecord
  mount_uploader :image, ProfileUploader

  class << self
    def index_faces(image_path)
      res = client.index_faces({
        collection_id: collection_id,
        image: {
          bytes: File.open(image_path, 'r+b')
        }
      })

      face_id = res.to_h[:face_records].map { |face| [face[:face][:face_id]]}.to_h
    end
  end

  has_many :posts
  
end
