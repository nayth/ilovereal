class Admin::PostsController < ApplicationController
	before_filter :verify_is_admin

	def index
		@posts = Post.order("id").page(params[:page]).per(4)
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.create post_params
		@category = params[:categories][:category_id]
		@post.post_categories.create(category_id: @category)
		@post.embed_info(params[:post][:embed])

		if @post.save
			redirect_to admin_posts_url, notice: 'post created'
		else
			render 'new'
		end
	end

	private

		def post_params
			params.require(:post).permit(:title, :description, :embed)
		end

		def verify_is_admin
			(current_user.nil?) ? redirect_to( new_user_session_path ) : (redirect_to( new_user_session_path ) unless current_user.admin?)
		end

end
