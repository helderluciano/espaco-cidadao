class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:destroy]

  def index
    @title = "Todos os Usuários"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    #@comments = @user.comments.paginate(:page => params[:page])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Cadastro"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Bem Vindo ao Espaço Cidadão!"
      redirect_to @user
    else
      @title = "Cadastro"
      render 'new'
    end
  end

  def edit
    @title = "Editar Cadastro"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Perfil Atualizado"
      redirect_to @user
    else
      @title = "Editar Cadastro"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Usuário Excluído!"
    redirect_to users_path
  end

  def following
    @title = "Seguindo"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Seguidores"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  private

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
	@user = User.find(params[:id])
	edirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    

end
