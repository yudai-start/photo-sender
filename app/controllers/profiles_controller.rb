class ProfilesController < ApplicationController
   
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def create
    Profile.create(profile_params)
    
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :email, :image)
  end
  
end
