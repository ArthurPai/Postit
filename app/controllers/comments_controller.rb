class CommentsController < ApplicationController
  before_action :login_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params) # TODO : app crash when comment body empty
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end