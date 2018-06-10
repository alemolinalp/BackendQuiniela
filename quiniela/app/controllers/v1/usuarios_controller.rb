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
        render json:{status: "Error", message: "Incorrect Password"}, status: :ok
      end
    else
      render json:{status: "Error", message: "Usuario no existe"}, status: :ok
    end
  end

  #Seguir un equipo
  def seguir
    usuario = Usuario.where(id: params[:idUsuario]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)
      #Por seguridad se le cambia el authentication token al usuario
      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join
      usuario.authentication_token = rand
      usuario.save

      equipoxusuario = Equipoxusuario.where(idUsuario: params[:idUsuario]).first

      if equipoxusuario
        equipoxusuario.idEquipo = params[:idEquipo]
        equipoxusuario.save
      else
        equipoxusuario = Equipoxusuario.new(idUsuario: params[:idUsuario], idEquipo: params[:idEquipo])
        equipoxusuario.save
      end

      render json:{status: "Success", message: "Seguir equipo", data: equipoxusuario, authentication_token: usuario.authentication_token}, status: :ok

    else
      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end

  end

  #Devolver el equipo que sigue
  def equipo
    usuario = Usuario.where(id: params[:idUsuario]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)
      #Por seguridad se le cambia el authentication token al usuario
      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join
      usuario.authentication_token = rand
      usuario.save

      usuarioEquipo = Equipoxusuario.where(idUsuario: params[:idUsuario]).first

      equipo = Equipo.where(id: usuarioEquipo.idEquipo)

      render json:{status: "Success", message: "Devolver equipo", data: equipo, authentication_token: usuario.authentication_token}, status: :ok

    else
      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end

  end

  #Facebook
  def fb
    user= Usuario.where(email: params[:email]).first

    if user
      render json:{status: "Success", message: "Iniciar Sesión", data: user}, status: :ok
    else
      user = Usuario.new(nombre: params[:nombre], email: params[:email], contrasena: 12345)
      if user.save
        render json: {status: "Success",message: "Nuevo usuario", data:user},status: :created
      else
        render json: {status: "Error", message:user.errors}, status: :bad
      end
    end
  end

end
