class ArticlesController < ApplicationController
	
	before_action :find_post, only: [:show, :edit, :update, :destroy,:upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]
	before_action :authenticate_editor!, only: [:new,:create,:update]
	before_action :authenticate_admin!, only: [:destroy]


	def index
		@articles = Article.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 6)
	end

	def show
		@article.update_visits_count
	end

	def new
		@article = current_user.articles.build
		@categories = Category.all.order("name ASC")
	end

	def create
		@article = current_user.articles.build(post_params)
		@article.categories = params[:categories]
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

	def upvote
		@article.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@article.downvote_by current_user
		redirect_to :back
	end

	private
	def find_post
		@article = Article.find(params[:id])
	end

	def post_params
		params.require(:article).permit(:title,:body,:cover, :categories)
	end 
end