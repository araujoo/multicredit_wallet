class ChangeCurrencyFieldsType < ActiveRecord::Migration[5.0]
  
  def up
  	change_column :card_wallets, :limit, :string
  	change_column :credit_cards, :current_balance, :string
  	change_column :purchases, :value, :string
  end

  def down
  	change_column :card_wallets, :limit, :integer
  	change_column :credit_cards, :current_balance, :integer
  	change_column :purchases, :value, :integer
  end
  
end
