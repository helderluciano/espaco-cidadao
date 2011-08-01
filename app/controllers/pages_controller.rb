class PagesController < ApplicationController
  
  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
    else
      @microposts = Micropost.find(:all)
    end
  end

  def contact
    @title = "Contato"
  end

  def help
    @title = "Tutorial"
  end

  def about
    @title = "Sobre"
  end


end
