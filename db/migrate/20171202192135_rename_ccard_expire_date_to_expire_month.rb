class RenameCcardExpireDateToExpireMonth < ActiveRecord::Migration[5.0]
  def up
  	rename_column :credit_cards, :expire_date, :expire_month
  end
  def down
  	rename_column :credit_cards, :expire_month, :expire_date
  end
end
