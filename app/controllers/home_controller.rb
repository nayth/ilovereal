class HomeController < ApplicationController
    def show
      @posts = Post.order("id").page(params[:page]).per(8)
      @categories = Category.all
    end
end
