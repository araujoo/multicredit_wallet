require 'singleton'
require 'dao_classes/user_dao'
require 'bigdecimal/util'
require 'dao_classes/card_wallet_dao'
class CardWalletAssistance
	include Singleton
	
	@card_wallet = nil

	def update_limit(limit_to_update, token)

		card_wallet = get_wallet(token)
		card_wallet.limit = limit_to_update
		if !card_wallet.valid?
			text = card_wallet.errors.messages
			status = 400
		elsif limit_to_update.to_d.truncate(2).to_f > get_max_available_limit(token)
			text = "Limite superior ultrapassa limite total disponivel" 	
			status = 200
		else
			card_wallet_dao = CardWalletDao.instance()
			if card_wallet_dao.update_card_wallet(card_wallet)
				text = "Limite atualizado com sucesso para #{limit_to_update}"
				status = 200
			else
				text = "Falha ao atualizar limite"
				status = 200
			end
		end
		{:text => text, :status => status}
	end

	def read_limit(token)
		card_wallet = get_wallet(token)
		card_wallet.limit
	end

	def get_max_available_limit(token)
		
		card_wallet = get_wallet(token)
		credit_cards = card_wallet.credit_cards
		
		max_available_limit = 0.0
		credit_cards.each do |c|
			max_available_limit = max_available_limit + c.limit.to_d.truncate(2).to_f
		end
		max_available_limit
	end

	def get_wallet(token)
		if @card_wallet == nil
			card_wallet_dao = CardWalletDao.instance()
			@card_wallet = card_wallet_dao.get_card_wallet(token)
		end
		@card_wallet
	end

	def get_spendable_lim(token)
		card_wallet = get_wallet(token)
		cards_used_lim = 0.0
		card_wallet.credit_cards.each do |c|
			cards_used_lim = cards_used_lim + c.used_credit.to_d.truncate(2).to_f
		end
		read_limit(token).to_d.truncate(2).to_f - cards_used_lim
	end
end