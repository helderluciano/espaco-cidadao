class CommentsController < ApplicationController

	before_filter :authenticate, :only => [:create, :destroy]
  	before_filter :authorized_user, :only => :destroy

 	def create
	        @microposts = Micropost.find(params[:micropost_id])
    		#@comments = @microposts.comments.create!(params[:comment])
		#@comment = @microposts.comments.create!(params[:micropost_id])
		@comment = @microposts.comments.create!(params[:comment])
		redirect_to @microposts
 		
	end

	def destroy
    		@comment.destroy
    		redirect_to @microposts
  	end

  	def show
    		@comments = Comment.find(params[:id])
 	end

	private

    def authenticate
      deny_access unless signed_in?
    end

    def authorized_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to root_path if @comment.nil?
    end
end
