class RemovePasswordDigestColumn < ActiveRecord::Migration[5.0]
  def up
  	remove_column :users, :password_digest
  	add_column :users, :encrypted_password, :string
  end
  def down
  	add_column :users, :password_digest, :string
  	remove_column :users, :encrypted_password
  end
end
