class V1::PartidosController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    partidos = Partido.all
    render json: {status: "Success", message: "Éxito ", data: partidos}, status: :ok
  end

  def partidosEquipo
    partidos = Partido.where(equipo1: params[:equipo]).or(Partido.where(equipo2: params[:equipo]))
    render json: {status: "Success", message: "Éxito ", data: partidos}, status: :ok
  end

  def ingresarResultado

    usuario = Usuario.where(id: params[:idUsuario]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)

      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join

      usuario.authentication_token = rand
      usuario.save

      partido = Partido.where(id: params[:idPartido]).first


      partido.resultado =  params[:resultado]
      partido.golesEquipo1 = params[:golesEquipo1]
      partido.golesEquipo2 = params[:golesEquipo2]

      equipo1 = Equipo.where(nombre: partido.equipo1).first
      equipo2 = Equipo.where(nombre: "Francia").first

      equipo1.golesFavor += partido.golesEquipo1
      equipo1.golesContra += partido.golesEquipo2


      equipo1.partidosJugados += 1


      #equipo2.golesFavor += partido.golesEquipo2

      '''
      equipo2.golesContra += partido.golesEquipo1
      equipo2.partidosJugados += 1



      if(partido.resultado == 1)
        equipo1.puntos += 3
        equipo1.partidosGanados += 1
        equipo2.partidosPerdidos += 1
      elsif(partido.resultado == 2)
        equipo2.puntos += 3
        equipo2.partidosGanados += 1
        equipo1.partidosPerdidos += 1
      else
        equipo1.puntos += 1
        equipo2.puntos += 1
        equipo1.partidosEmpatados += 1
        equipo2.partidosEmpatados += 1
      end
      '''
      render json:{status: "Success", message: "Ingreso de resultados", data: equipo2, authentication_token: usuario.authentication_token}, status: :ok
    else

      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end
  end
end
