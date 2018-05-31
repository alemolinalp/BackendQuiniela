class CreateUsuarioxjuegos < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarioxjuegos do |t|
      t.integer :idUsuario
      t.integer :idJuego
      t.integer :aciertos
      t.timestamps
    end
  end
end
