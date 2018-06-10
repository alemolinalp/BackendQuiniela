class SesionesController < ApplicationController
  def new
  end

  def create
    user = Usuario.authenticate(params[:sesion][:email], params[:sesion][:password])

    if user.nil?
      flash.now[:error] = "Email o contrasena invalido"
      render :new
    else
      #flash.now[:error] = "Email o contrasena correcto Ale"
      #render :new
      sign_in user
      redirect_to rails_admin_path
    end
  end

  def destroy
    sign_out
    redirect_to signin_path
  end
end
