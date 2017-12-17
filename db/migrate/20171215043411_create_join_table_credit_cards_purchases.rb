class CreateJoinTableCreditCardsPurchases < ActiveRecord::Migration[5.0]
  def change
    create_join_table :credit_cards, :purchases do |t|
       t.index [:credit_card_id, :purchase_id]
       t.index [:purchase_id, :credit_card_id]
    end
  end
end
