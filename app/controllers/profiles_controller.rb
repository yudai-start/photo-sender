class ProfilesController < ApplicationController
 
  

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new(profile_params)
    profile.save
    image_path = profile_params[:image].original_filename
    face_ids = registration_face(image_path)
    refine_face_id(face_ids, profile)
  end


  private
  def profile_params
    params.require(:profile).permit(:name, :email, :image)
  end

  # def image_path
  #   params.require(:profile).permit(:image)
  # end



end
