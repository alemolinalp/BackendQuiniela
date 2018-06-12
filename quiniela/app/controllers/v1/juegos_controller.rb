class V1::JuegosController < ApplicationController
  protect_from_forgery with: :null_session

  #Crear una quiniela
  def create
    usuario = Usuario.where(id: params[:id]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)

      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join

      r = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      codigo = (0...5).map{r[rand(r.length)]}.join

      usuario.authentication_token = rand
      usuario.save

      juego = Juego.new(nombre: params[:nombre], participantes: params[:participantes], idPropietario: params[:id], monto: params[:monto], codigo: codigo)

      #render json:{status: "Success", message: "Quiniela creada", data: juego}, status: :created
      if juego.save
        usuarioJuego = Usuarioxjuego.new(idUsuario: params[:id], idJuego: juego.id, aciertos: 0)
        usuarioJuego.save
        render json:{status: "Success", message: "Quiniela creada", data: juego, authentication_token: usuario.authentication_token}, status: :created
      else
        render json:{status: "Error", message: "No se pudo crear quiniela"}, status: :ok
      end
    else
      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end
  end

  #Agregar un usuario a una quiniela
  def add
    usuario = Usuario.where(id: params[:id]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)
      #Por seguridad se le cambia el authentication token al usuario
      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join
      usuario.authentication_token = rand
      usuario.save

      juego= Juego.where(codigo: params[:codigo]).first

      if juego
        usuarioJuego = Usuarioxjuego.where(idUsuario: params[:id]).where(idJuego: juego.id)
        if (usuarioJuego == [])
          juegoUsuario = Usuarioxjuego.new(idUsuario: params[:id], idJuego: juego.id, aciertos: 0)
          juegoUsuario.save
          render json:{status: "Success", message: "Usuario unido a quiniela", data: juegoUsuario, authentication_token: usuario.authentication_token}, status: :created
        else
          render json:{status: "Error", message: "El usuario ya esta unido a esa quiniela", data: usuarioJuego}, status: :ok
        end
      else
        render json:{status: "Error", message: "No existe una quiniela con ese codigo"}, status: :ok
      end
    else
      render json:{status: "Error", message: "Token invalido"}, status: :ok
    end
  end

  #Obtener quinielas de un usuario
  def obtenerQuinielas
    usuario = Usuario.where(id: params[:id]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)
      #Por seguridad se le cambia el authentication token al usuario
      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join
      usuario.authentication_token = rand
      usuario.save

      usuarioJuego = Usuarioxjuego.where(idUsuario: params[:id])

      quinielas = []

      usuarioJuego.each do |item|
        juegos = Juego.where(id: item.idJuego)
        quinielas.push(juegos)
      end

      render json:{status: "Success", message: "Quinielas del usuario", data: quinielas, authentication_token: usuario.authentication_token}, status: :ok
    else
      render json:{status: "Error", message: "Token invalido"}, status: :ok
    end
  end

  #Obtener participantes por quiniela
  def obtenerParticipantes
    usuario = Usuario.where(id: params[:id]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)
      #Por seguridad se le cambia el authentication token al usuario
      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join
      usuario.authentication_token = rand
      usuario.save

      usuarioJuego = Usuarioxjuego.where(idJuego: params[:idQuiniela])

      quinielas = []

      usuarioJuego.each do |item|
        usuarios = Usuario.where(id: item.idUsuario)
        quinielas.push(usuarios)
      end

      render json:{status: "Success", message: "Usuarios de una quiniela", data: quinielas, authentication_token: usuario.authentication_token}, status: :ok
    else
      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end
  end

  #Actualizar aciertos
  def actualizar
    usuario = Usuario.where(id: params[:idUsuario]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)
      #Por seguridad se le cambia el authentication token al usuario
      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join
      usuario.authentication_token = rand
      usuario.save


      resultados = ResultadoJuego.where(idJuego: params[:idQuiniela])

      lista = []

      resultados.each do |item|
        juegousuario = Usuarioxjuego.where(idJuego: params[:idQuiniela]).where(idUsuario: item.idUsuario).first
        if(juegousuario != nil)
          juegousuario.aciertos = 0
          juegousuario.save
          #lista.push(juegousuario)
        end
      end
      resultados.each do |item|
        juegousuario = Usuarioxjuego.where(idJuego: params[:idQuiniela]).where(idUsuario: item.idUsuario).first

        partido = Match.where(id: item.idPartido).first

        if(partido.resultado != 0)
          lista.push(partido)
          if(item.prediccion == partido.resultado)
            if(juegousuario != nil)
              juegousuario.aciertos += 1
              juegousuario.save
            end
          end
        end

      end

      usuariojuegos = Usuarioxjuego.where(idJuego: params[:idQuiniela]).order(:aciertos)

      usuarios = []

      usuariojuegos.each do |item|
        u = Usuario.where(id: item.idUsuario)
        usuarios.push(u)
      end

      render json:{status: "Success", message: "Aciertos", data: usuariojuegos, usuarios: usuarios, authentication_token: usuario.authentication_token}, status: :ok

    else
      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end

  end
end
