class CreateEquipos < ActiveRecord::Migration[5.2]
  def change
    create_table :equipos do |t|
      t.string :codigo
      t.string :nombre
      t.integer :idGrupo
      t.integer :puntos
      t.integer :partidosJugados
      t.integer :partidosGanados
      t.integer :partidosEmpatados
      t.integer :partidosPerdidos
      t.integer :golesFavor
      t.integer :golesContra
      t.timestamps
    end
  end
end
