class AdjustDbSchema < ActiveRecord::Migration[5.0]
  def up
  	drop_table :paid_withs
  	drop_table :user_wallets
  	rename_column :credit_cards, :current_balance, :used_credit
  end

  def down
  	rename_column :credit_cards, :used_credit, :current_balance
	create_table "paid_withs", force: :cascade do |t|
	  t.datetime "created_at", null: false
	  t.datetime "updated_at", null: false
	end
	create_table "user_wallets", force: :cascade do |t|
	  t.integer  "limit"
	  t.datetime "created_at", null: false
	  t.datetime "updated_at", null: false
	end
  end
end
