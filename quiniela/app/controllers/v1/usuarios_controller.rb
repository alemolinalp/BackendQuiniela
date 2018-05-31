class V1::UsuariosController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    token = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
    auth_token = (0...20).map{token[rand(token.length)]}.join

    usuario = Usuario.where(email: params[:email]).first

    if usuario
      render json:{status: "Error", message: "El usuario ya existe"}
    else
      user = Usuario.new(nombre: params[:nombre], email: params[:email], contrasena: [:contrasena], authentication_token: auth_token)
      if user.save
        render json: {status: "Sucess", message: "Usuario creado", usuario:user}, status: :created
      else
        render json:{status: "Error", message: user.errors}, status: :bad
      end
    end
  end
end
