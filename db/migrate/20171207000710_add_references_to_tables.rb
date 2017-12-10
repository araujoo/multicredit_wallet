class AddReferencesToTables < ActiveRecord::Migration[5.0]
  def up
  	add_reference :card_wallets, :user, foreign_key: true
  	add_reference :purchases, :user, foreign_key: true
  	add_reference :credit_cards, :card_wallet, foreign_key: true
  end
  def down
  	remove_reference :card_wallets, :user
  	remove_reference :purchases, :user
  	remove_reference :credit_cards, :card_wallet
  end  
end
