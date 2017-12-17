class Purchase < ApplicationRecord
	belongs_to :card_wallet
	has_and_belongs_to_many :credit_cards
end
