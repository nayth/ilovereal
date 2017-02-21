class Admin::CategoriesController < ApplicationController
  before_filter :verify_is_admin

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to root_url
    else
      render('new')
    end
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end


    def verify_is_admin
      (current_user.nil?) ? redirect_to( new_user_session_path ) : (redirect_to( new_user_session_path ) unless current_user.admin?)
    end
end
