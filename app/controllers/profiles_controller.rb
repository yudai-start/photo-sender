class ProfilesController < ApplicationController
 
  

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    Profile.create(profile_params)  
    image_path = profile_params[:image].original_filename
    index_face(image_path)
  end


  private
  def profile_params
    params.require(:profile).permit(:name, :email, :image)
  end

  # def image_path
  #   params.require(:profile).permit(:image)
  # end



end
