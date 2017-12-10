class ChangeLimitType < ActiveRecord::Migration[5.0]
  def up
  	change_column :credit_cards, :limit, :string
  end

  def down
  	change_column :credit_cards, :limit, :integer
  end
end
