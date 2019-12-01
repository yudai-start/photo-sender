class Profile < ApplicationRecord
  mount_uploader :image, ProfileUploader

  # def self.index_faces(image_path)
  #   res = client.index_faces({
  #     collection_id: profile-photos,
  #     image: {
  #       bytes: image_bytes,
  #       s3_object: {
  #         bucket: "photo-sender-posts",
  #         name: "uploads/profile/image/#{image_path}",
  #       },
  #     },
  #   })

    # face_id = res.to_h[:face_records].map { |face| [face[:face][:face_id]]}.to_h
    
  # end

  # has_many :posts
  
end
