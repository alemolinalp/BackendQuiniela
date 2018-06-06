class V1::EquiposController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    equipos = Equipo.all
    render json: {status: "Success", message: "Éxito ", data: equipos}, status: :ok
  end

  def grupo
    equipos = Equipo.where(idGrupo: params[:grupo])
    render json: {status: "Success", message: "Éxito ", data: equipos}, status: :ok
  end

  def equipo
    equipos = Equipo.where(id: params[:equipo])
    render json: {status: "Success", message: "Éxito ", data: equipos}, status: :ok
  end

end
