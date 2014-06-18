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

  def vote
    comment = Comment.find(params[:id])
    vote = Vote.create(vote: params[:vote], creator: current_user, voteable: comment)

    if vote.valid?
      flash[:notice] = 'Your vote was counted'
    else
      flash[:error] = 'You can only vote on a comment once.'
    end

    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end