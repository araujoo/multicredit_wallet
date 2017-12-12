class RearrangeDbSchema < ActiveRecord::Migration[5.0]
  def up
  	add_reference :purchases, :card_wallet, foreign_key: true
  	remove_reference :users, :purchase
  end
  def down
	add_reference :purchases, :user, foreign_key: true
  	remove_reference :purchases, :card_wallet
  end  
end
