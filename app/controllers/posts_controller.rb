class PostsController < ApplicationController
  def index
    @posts = Post.order(:id).page(params[:page]).per(9)
  end

  def show
		@post = Post.find(params[:id])
    @more_videos = Post.order("RANDOM()").limit(4)
	end
end
