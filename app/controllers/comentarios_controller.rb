class ComentariosController < ApplicationController
  
  def show
    @comentario = Comentario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comentario }
    end
  end

  
  def create
    @comentario = Comentario.new(params[:comentario])

      if @comentario.save
	flash[:success] = "Comentário criado com sucesso!"
      redirect_back_or root_path
      end
    end

  
  def destroy
    @comentario = Comentario.find(params[:id])
    @comentario.destroy

    end

end
