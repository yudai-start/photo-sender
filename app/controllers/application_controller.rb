class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index_face(image_path,profile)
    require "aws-sdk-rekognition"
   
    Aws.config.update({
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],ENV['AWS_SECRET_ACCESS_KEY'])
    })
    
    rekog = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])

    result = rekog.index_faces({
      collection_id: "profile-photos",
      image: {
        s3_object: {
          bucket: "photo-sender-posts",
          name: "uploads/profile/#{image_path}",
        },
      }
    })

    face_id = result[:face_records].map{ |face| [face[:face][:face_id]]}
    face_id = face_id[0][0]
    profile.face_id = "#{face_id}"
    profile.save
  end
end
