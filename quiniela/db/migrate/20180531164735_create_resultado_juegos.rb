class CreateResultadoJuegos < ActiveRecord::Migration[5.2]
  def change
    create_table :resultado_juegos do |t|
      t.integer :idUsuario
      t.integer :idJuego
      t.integer :idPartido
      t.integer :prediccion
      t.timestamps
    end
  end
end
