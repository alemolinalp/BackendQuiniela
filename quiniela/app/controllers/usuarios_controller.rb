class UsuariosController < ApplicationController
  def new
    @usuario = Usuario.new
  end

  def create
    #Revisar este @usuario
    @usuario = Usuario.new(params[:usuario])
    if @usuario.save
      redirect_to @usuario, notice: 'Usuario creado'
    else
      render action: "new"
    end
  end

  def show
    @usuario = Usuario.find(params[:id])
  end
end
