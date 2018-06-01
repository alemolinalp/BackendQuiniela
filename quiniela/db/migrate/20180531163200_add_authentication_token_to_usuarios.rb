class AddAuthenticationTokenToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :authentication_token, :string
  end
end
