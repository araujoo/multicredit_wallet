class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.integer :card_nr
      t.string :print_name
      t.date :billing_date
      t.date :expire_date
      t.integer :cvv
      t.integer :limit

      t.timestamps
    end
  end
end
