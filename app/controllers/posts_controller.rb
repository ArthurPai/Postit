class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :login_user, except: [:index, :show]
  before_action :creator_user, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Post Created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post Updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def creator_user
      unless current_user?(@post.creator)
        flash[:error] = "You can't do that."
        redirect_to root_path
      end
    end

end
