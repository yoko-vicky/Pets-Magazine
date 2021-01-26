class CategoriesController < ApplicationController
  before_action :require_login, except: %i[index show]
  before_action :set_category, only: %i[show]

  def index
    @categories = Category.includes(:articles).prioritize
    @most_popular_article = most_popular_article
  end

  def show
    @articles = @category.articles.includes(:author).order_by_created
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} was successfully created."
      redirect_to @category
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :priority)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def most_popular_article
    return if Article.first.nil?

    hash = Vote.includes(:article_id).group(:article_id).order(count_all: :desc).limit(1).count
    if hash.empty?
      Article.includes(%i[category author]).latest
    else
      Article.includes(%i[category author]).find(hash.to_a.flatten[0])
    end
  end
end
