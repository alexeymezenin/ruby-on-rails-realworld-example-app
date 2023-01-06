class ArticlesController < ApplicationController
  before_action :set_article!, only: %i[show update destroy favorite unfavorite]

  def index
    @articles = Article.order(created_at: :desc).includes(:user)

    @articles = @articles.offset(params[:offset]).limit(params[:limit]) if params[:offset].present? and params[:limit].present?
    @articles = @articles.fitler_by_tag(params[:tag]) if params[:tag].present?
    @articles = @articles.filter_by_author(params[:author]) if params[:author].present?
    @articles = @articles.filter_by_favorited(params[:favorited]) if params[:favorited].present?

    render_articles
  end

  def feed
    @articles = Article.order(created_at: :desc).where(user: @current_user.followers).includes(:user)

    render_articles
  end

  def show
    render_article
  end

  def create
    @article = @current_user.articles.new(article_params.except(:tagList))

    if @article.save
      @article.sync_tags(article_params[:tagList])

      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    unless owner?(@article)
      render_unauthorized and return
    end

    if @article.update(article_params)
      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    unless owner?(@article)
      render_unauthorized and return
    end

    @article.destroy
  end

  def favorite
    @article.favorite @current_user

    render_article
  end

  def unfavorite
    @article.unfavorite @current_user

    render_article
  end

  private

  def set_article!
    @article = Article.find_by_slug(params[:slug])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body, tagList: [])
  end

  def render_article
    render json: { article: @article.as_json({}, @current_user) }
  end

  def render_articles
    render json: { articles: @articles, articlesCount: @articles.count }
  end
end
