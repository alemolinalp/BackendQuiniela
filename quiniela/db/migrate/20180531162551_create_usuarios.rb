class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.string :nombre
      t.string :email
      t.string :contrasena
      t.string :foto
      t.timestamps
    end
  end
end
