class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :Purchases, :CreditCards do |t|
       t.index [:purchase_id, :credit_card_id]
       t.index [:credit_card_id, :purchase_id]
    end
  end
end
