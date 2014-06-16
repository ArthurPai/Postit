class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

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
    user = User.find(1) #TODO after user authentication

    @post = user.posts.build
    if categories_not_exist
      render :new
    else
      @post = user.posts.build(post_params)

      if @post.save
        flash[:notice] = "Post Created."
        redirect_to posts_path
      else
        render :new
      end
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

    def categories_not_exist
      all_categorie_ids = Category.all.ids
      category_ids = post_params[:category_ids]

      unless category_ids.all? { |e| all_categorie_ids.include?(e) }
        @post.errors.add(:category_ids, "have some category is not exist")
      end
    end

end
