class PostsController < ApplicationController
    
  def index
        @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    image_path = post_params[:image].original_filename
    search_all_faces_by_image(image_path)


  end

  private
  def post_params
    params.require(:post).permit(:content, :image)
  end

end
