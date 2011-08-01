class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Postagem Criada!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  def show
    @microposts = Micropost.find(params[:id])
    #@comments = @micropost.comments.user.find(params[:user])
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

    #def current_user=(user)
    	#@current_user = user
    #end
end
