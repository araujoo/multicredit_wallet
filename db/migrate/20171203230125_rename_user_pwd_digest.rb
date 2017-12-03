class RenameUserPwdDigest < ActiveRecord::Migration[5.0]
	def up
		rename_column :users, :password_diggest, :password_digest
	end
	def down
		rename_column :users, :password_digest, :password_diggest
	end
end
