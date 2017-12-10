class CardWallet < ApplicationRecord
	belongs_to :user
	has_many :credit_cards, dependent: :destroy

	validates :user_id, uniqueness: { message: "Usuario \"%{value}\" ja possui uma wallet" }

end
