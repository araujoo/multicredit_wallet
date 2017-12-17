require 'singleton'
require 'bigdecimal/util'
require 'dao_classes/card_wallet_dao'
class CardWalletAssistance
	include Singleton
	
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
		card_wallet_dao = CardWalletDao.instance()
		card_wallet_dao.get_card_wallet(token)
	end

	def get_spendable_lim(token)
		card_wallet = get_wallet(token)
		cards_used_lim = 0.0
		card_wallet.credit_cards.each do |c|
			cards_used_lim = cards_used_lim + c.used_credit.to_d.truncate(2).to_f
		end
		spendable_lim = read_limit(token).to_d.truncate(2).to_f - cards_used_lim
		if spendable_lim < 0.0
			spendable_lim = 0.0
		end
	end

	def adjust_max_wallet_limit(token)

		message = Array.new

		card_wallet = get_wallet(token)
		max_limit = get_max_available_limit(token)
		if card_wallet.limit.to_d.truncate(2).to_f >= max_limit
			card_wallet.limit = sprintf("%.2f", max_limit.to_s)

			c_wallet_dao = CardWalletDao.instance()
			c_wallet_dao.update_card_wallet(card_wallet)
		end
	end

	def get_purchase_history(token)
		#message_object = Struct.new(:Valor, :Data, :Cartoes)
		message = Array.new
		card_wallet = get_wallet(token)
		purchases = card_wallet.purchases.sort_by{ |purch| [purch.created_at]}
		purchases.each_with_index do |p, i|
			
			#recupera os cartoes utilizados na compra
			purch_cards = p.credit_cards
			
			#cria um vetor apenas com o numero dos cartoes utilizados na compra
			purch_cards_arr = Array.new

			#processa os dados para exibicao
			purch_cards.each do |pc|
				purch_cards_arr.push(pc.card_nr)
			end
			message.push({:Objeto => "#{i+1}", :Valor => p.value, :Date => p.created_at, :Cartoes => purch_cards_arr})
		end
		message
	end
end