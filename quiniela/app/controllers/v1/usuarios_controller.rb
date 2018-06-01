class V1::UsuariosController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    token = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
    auth_token = (0...20).map{token[rand(token.length)]}.join

    usuario = Usuario.where(email: params[:email]).first

    if usuario
      render json:{status: "Error", message: "El usuario ya existe"}
    else
      user = Usuario.new(nombre: params[:nombre], email: params[:email], contrasena: params[:contrasena], authentication_token: auth_token)
      if user.save
        render json: {status: "Success", message: "Usuario creado", usuario:user}, status: :created
      else
        render json:{status: "Error", message: user.errors}, status: :bad
      end
    end
  end
  def login
    usuario = Usuario.where(email: params[:email]).first
    contrasena = params[:contrasena]

    if usuario
      if (usuario.contrasena == contrasena)
        token = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
        auth_token = (0...20).map{token[rand(token.length)]}.join
        usuario.authentication_token = auth_token
        usuario.save
        render json:{status: "Success", message: "Log in", data: usuario}, status: :created
      else
        render json:{status: "Error", message: "Incorrect Password"}, status: :bad
      end
    else
      render json:{status: "Error", message: "Usuario no existe"}, status: :bad
    end
  end
end
