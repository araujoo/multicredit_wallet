class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :authentication_token, :string, limit: 30
    add_index :users, :authentication_token, unique: true
  end

  def down
    remove_column :users, :authentication_token
    remove_index :users, :authentication_token
  end  
end
