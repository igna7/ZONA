class ArticlesController < ApplicationController
	
	before_action :find_post, only: [:show, :edit, :update, :destroy]

	def index
		@articles = Article.all.order("created_at DESC")
	end

	def show
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(post_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(post_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		redirect_to root_path
	end

	private
	def find_post
		@article = Article.find(params[:id])
	end

	def post_params
		params.require(:article).permit(:title,:body)
	end 
end