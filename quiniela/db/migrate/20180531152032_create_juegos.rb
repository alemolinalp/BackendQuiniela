class CreateJuegos < ActiveRecord::Migration[5.2]
  def change
    create_table :juegos do |t|
      t.string :nombre
      t.integer :participantes
      t.timestamps
    end
  end
end
