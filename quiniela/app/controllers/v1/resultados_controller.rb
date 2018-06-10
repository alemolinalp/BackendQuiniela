class V1::ResultadosController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    usuario = Usuario.where(id: params[:idUsuario]).first


    #token = params[:authentication_token]

    #if(usuario.authentication_token == token)

      #random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      #rand = (0...20).map{random[rand(random.length)]}.join

      #r = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      #codigo = (0...5).map{r[rand(r.length)]}.join

      #usuario.authentication_token = rand
      #usuario.save


      resultado = ResultadoJuego.new(idUsuario: params[:idUsuario], idJuego: params[:idJuego], idPartido: params[:idPartido], prediccion: params[:prediccion])
      resultado.save

      #render json:{status: "Success", message: "Resultado creado", data: resultado, authentication_token: usuario.authentication_token}, status: :created
      render json:{status: "Success", message: "Resultado creado", data: resultado}, status: :created

    #else
      #render json:{status: "Error", message: "Token invalido"}, status: :bad
  #end


  end

  def obtenerResultados
    usuario = Usuario.where(id: params[:idUsuario]).first

    token = params[:authentication_token]

    if(usuario.authentication_token == token)

      random = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      rand = (0...20).map{random[rand(random.length)]}.join

      r = [('a'..'z'),('A'..'Z'),('0'..'9')].map(&:to_a).flatten
      codigo = (0...5).map{r[rand(r.length)]}.join

      usuario.authentication_token = rand
      usuario.save

      resultados = ResultadoJuego.where(idUsuario: params[:idUsuario])

      render json:{status: "Success", message: "Obtener resultado", data: resultados, authentication_token: usuario.authentication_token}, status: :ok
    else
      render json:{status: "Error", message: "Token invalido"}, status: :bad
    end

  end

end
