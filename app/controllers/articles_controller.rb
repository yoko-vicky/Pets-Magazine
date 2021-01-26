class ArticlesController < ApplicationController
  before_action :require_login, except: %i[index]
  before_action :set_article, only: %i[show edit update destroy]
  before_action only: %i[edit update destroy] do
    require_same_user(@article.author)
  end

  def index
    @articles = Article.includes(%i[category author]).order_by_created.latest16
  end

  def favorites
    @articles = Article.where(id: Vote.where(user_id: current_user.id).pluck(:article_id))
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id

    if @article.save
      flash[:notice] = "#{@article.title} was successfully created"
      redirect_to @article
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = "#{@article.title} was successfully updated"
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "#{@article.title} was successfully deleted"
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :category_id, :image)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
