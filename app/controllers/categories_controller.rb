class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:posts)
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.page(params[:page]).per(12)
  end
end
