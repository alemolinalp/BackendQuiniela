class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :equipo1
      t.integer :equipo2
      t.integer :resultado
      t.integer :golesEquipo1
      t.integer :golesEquipo2
      t.string :fecha
      t.string :lugar
      t.integer :finalizado
      t.timestamps
    end
  end
end
