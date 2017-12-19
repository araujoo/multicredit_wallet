class Purchase < ApplicationRecord
	belongs_to :card_wallet
	has_and_belongs_to_many :credit_cards

	validate :value_should_not_be_negative
	validate :purchase_must_have_credit_cards

	def value_should_not_be_negative
		if value && value.to_d.truncate(2).to_f < 0.0
			errors.add(:value, 'Campo "Valor" nao deve ser negativo')
		end
	end
end
