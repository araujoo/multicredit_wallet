class CardWallet < ApplicationRecord
	belongs_to :user
	has_many :credit_cards, dependent: :destroy

	validates :user_id, uniqueness: { message: "Usuario \"%{value}\" ja possui uma wallet" }
	validates_format_of :limit, :with => /(\A(\.|[0-9]*\.))[0-9]{2}\z/, :message => 'Campo "Limite" invalido. Favor inserir um valor no formato "123.00"'

end
