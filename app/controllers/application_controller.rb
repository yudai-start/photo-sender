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
  
  def save_face_id(face_ids, profile)
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

  def search_all_faces_by_image(image_path,post)

    require "aws-sdk-rekognition"
   
    Aws.config.update({
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],ENV['AWS_SECRET_ACCESS_KEY'])
    })
    
    rekog = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])

    face_ids = registration_face(image_path)

    matched_face_ids = face_ids.map do |face_id|
      face_id = face_id[0]
      search_face(face_id)
    end

    #登録したFace_idの削除
    face_ids.map do |face_id|
      face_id = face_id[0]
      rekog.delete_faces({
      collection_id: "profile-photos", 
      face_ids: [
        "#{face_id}", 
      ], 
    })
    end

    #postテーブルにmatched_face_idを登録する
    #ここから、仮に写真に一人しか写ってないと言う仮定で作っていこう！
    matched_face_ids = matched_face_ids[0]
    post.match_face_id = "#{matched_face_ids}"
    post.save

    puts "#{matched_face_ids}+ああああ"
    return matched_face_ids

  end

  def save_matched_faces(matched_face_ids, post)
    matched_face_id = face_ids[0]
    profile.face_id = "#{matched_face_id}"
  end


end
