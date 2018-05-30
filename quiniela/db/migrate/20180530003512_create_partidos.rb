class CreatePartidos < ActiveRecord::Migration[5.2]
  def change
    create_table :partidos do |t|
      t.string :equipo1
      t.string :equipo2
      t.integer :resultado
      t.integer :golesEquipo1
      t.integer :golesEquipo2
      t.string :fecha
      t.string :lugar
      t.timestamps
    end
  end
end
