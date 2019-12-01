class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def registration_face(image_path)
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
          name: "uploads/#{image_path}",
        },
      }
    })

    face_ids = result[:face_records].map{ |face| [face[:face][:face_id]]}

    return face_ids
  end
  
  def refine_face_id(face_ids, profile)
    face_id = face_ids[0][0]
    profile.face_id = "#{face_id}"
    profile.save
  end
  

  def search_face(face_id)
    require "aws-sdk-rekognition"
   
    Aws.config.update({
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],ENV['AWS_SECRET_ACCESS_KEY'])
    })
    
    rekog = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])

    result = rekog.search_faces({
      collection_id: "profile-photos",
      face_id: "#{face_id}",
      face_match_threshold: 50
    })

    matched_face_id = result[:face_matches][0][:face][:face_id]
    return matched_face_id
  end

  def search_all_faces_by_image(image_path)

    require "aws-sdk-rekognition"
   
    Aws.config.update({
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],ENV['AWS_SECRET_ACCESS_KEY'])
    })
    
    rekog = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])

    face_ids = registration_face(image_path)

    matched_faces = face_ids.map do |face_id|
      face_id = face_id[0]
      search_face(face_id)
    end
    puts "#{matched_faces}+ああああ"
  end

end
