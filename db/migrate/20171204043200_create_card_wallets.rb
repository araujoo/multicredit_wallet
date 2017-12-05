class CreateCardWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :card_wallets do |t|
      t.integer :limit

      t.timestamps
    end
  end
end
