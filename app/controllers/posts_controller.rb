# controller for post model
class PostsController < ApplicationController
  # code duoc goi truoc khi goi bat cu method nao
  before_action :authenticate_user!
  # duoc goi truoc moi lan show, destroy duoc goi
  before_action :find_post, only: [:show, :destroy]

  # list tat ca cac posts
  def index
    @posts = Post.all.limit(10).includes(:photos, :user, :likes).order('created_at desc')
    @post = Post.new
  end

  # create a post
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
          @post.photos.create(image: params[:images][img])
        end
      end

      redirect_to posts_path
      flash[:notice] = 'Saved ...'
    else
      flash[:alert] = 'Something went wrong ...'
      redirect_to posts_path
    end
  end

  # show a post
  def show
    @photos = @post.photos
    @likes = @post.likes.includes(:user)
    @is_liked = @post.is_liked(current_user)
  end

  # destroy -delete- a post
  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = 'Post deleted!'
      else
        flash[:alert] = 'Something went wrong...'
      end
    else
      flash[:notice] = "You don't have permission to do that!"
    end
    redirect_to root_path
  end

  private # private methods below

  # tim kiem 1 post theo id
  def find_post
    @post = Post.find_by id: params[:id]

    return if @post

    flash[:danger] = 'Post not exist!'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit :content
  end
end
