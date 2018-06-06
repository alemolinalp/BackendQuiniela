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
end
