class AddColumnsToJuego < ActiveRecord::Migration[5.2]
  def change
    add_column :juegos, :idPropietario, :integer
    add_column :juegos, :monto, :integer
    add_column :juegos, :codigo, :string
  end
end
