class CommentsController < ApplicationController
  before_action :set_article!, only: %i[index create destroy]

  def index
    render json: { comments: Comment.all }
  end

  def create
    comment = @article.comments.new(comment_params.merge({ user_id: @current_user.id }))

    if comment.save
      render json: comment.as_json({}, @current_user), status: :created, location: comment
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.comments.destroy(params[:id])
  end

  private

  def set_article!
    @article = Article.find_by_slug!(params[:article_slug])
  end

  def comment_params
    params.permit(:body)
  end
end
