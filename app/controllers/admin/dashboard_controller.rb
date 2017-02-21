class Admin::DashboardController < ApplicationController

before_filter :verify_is_admin
  def index
    @total_posts = Post.count
    @posts = Post.order("id").page(params[:page]).per(4)
    @categories_total = Category.count
  end

  def verify_is_admin
    (current_user.nil?) ? redirect_to( new_user_session_path ) : (redirect_to( new_user_session_path ) unless current_user.admin?)
  end
end
