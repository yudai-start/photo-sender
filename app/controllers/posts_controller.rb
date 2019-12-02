class PostsController < ApplicationController
    
  def index
        @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    image_path = post_params[:image].original_filename
    search_all_faces_by_image(image_path,post)
    puts "#{post.profile.email}+いいいいいい"
    NotificationMailer.send_confirm_to_user(post).deliver_later
  end

  private
  def post_params
    params.require(:post).permit(:content, :image)
  end

end
