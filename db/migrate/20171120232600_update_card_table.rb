class UpdateCardTable < ActiveRecord::Migration[5.0]
  def up
  	add_column :credit_cards, :current_balance, :integer
  	change_column(:credit_cards, :billing_date, :string)
    change_column(:credit_cards, :expire_date, :string)
    change_column(:credit_cards, :card_nr, :string)
  	change_column(:credit_cards, :cvv, :string)
  end
  def down
  	 remove_column :credit_cards, :current_balance
  	 change_column(:credit_cards, :billing_date, :date)
  	 change_column(:credit_cards, :expire_date, :date)
     change_column(:credit_cards, :card_nr, :integer)
     change_column(:credit_cards, :cvv, :integer)
  end

end
