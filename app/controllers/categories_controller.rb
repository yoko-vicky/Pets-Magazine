class CategoriesController < ApplicationController
  before_action :require_login, except: %i[index show]
  before_action :set_category, only: %i[show]

  def index
    @categories = Category.includes(:articles).prioritize
  end

  def show
    @articles = @category.articles.order_by_created.includes(:author)
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
end
