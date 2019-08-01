class CommentsController < ApplicationController
  def index
    if params.has_key?(:user_id)
      user_comments = User.find(params[:user_id]).comments
      render json: user_comments
    elsif params.has_key?(:artwork_id)
      artworks_comments = Artwork.find(params[:artwork_id]).comments
      render json: artworks_comments
    end
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment.destroy
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :artwork_id, :body)
  end
end
