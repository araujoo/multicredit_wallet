 require 'singleton'
 require 'dao_classes/credit_card_dao'
 require 'dao_classes/user_dao'
 require 'application_assistance'
 require 'card_wallet_assitance_class'

 class CreditCardAssistance
 	include Singleton

	def list_cards(token)
		ccards_dao = CreditCardDao.instance()

		#realiza a consulta ao banco
		credit_cards = ccards_dao.get_credit_cards(token)

		#inicializa o dado de retorno
		user_cards = Array.new

		credit_cards.each do |c|
			user_cards.push({
				"Número do Cartão" => "#{c.card_nr}",
				"Nome Impresso no Cartão" => "#{c.print_name}",
				"Data de Vencimento" => "#{c.billing_date}\/#{c.billing_month}",
				"Validade do Cartão" => "#{c.expire_month}\/#{c.expire_year}",
				"CVV" => "#{c.cvv}",
				"Limite do Cartão" => "#{c.limit}",
				"Cadastrado no dia" => "#{c.created_at}",
				"Atualizado no dia" => "#{c.updated_at}",
				"Saldo Atual :" => "#{c.used_credit}"
			})			
		end
		
		credit_cards_json = user_cards.to_json
		credit_cards_json
	end

 	def add_cards(parsed_json_cards, token)

 		#recupera a instancia da classe DAO
 		ccards_dao = CreditCardDao.instance()

 		#inicializa o array de cartoes
 		card_array = Array.new

	  	#se foi recebido apenas um cartao, e nao um array de objetos,
	  	#adicionar o objeto a um array para que a logica de processamento
	  	#seja heterogenea
	  	if !parsed_json_cards.is_a?(Array)
	  		parsed_json_cards_arr = Array.new
	  		parsed_json_cards_arr.push(parsed_json_cards)
	  	else
	  		parsed_json_cards_arr = parsed_json_cards
	  	end

	  	#monta o array com as instancias que serao persistidas no banco
	  	parsed_json_cards_arr.each do |c|
	  		card_array.push(
	  			new_credit_card = CreditCard.new(
	  				:card_nr => c['Numero do Cartao'].to_s,
	  				:print_name => c['Nome Impresso'],
	  				:billing_date => c['Dia de Cobranca'],
	  				:billing_month => c['Mes de Cobranca'],
	  				:expire_month => c['Mes de Expiracao'],
	  				:expire_year => c['Ano de Expiracao'],
	  				:cvv => c['CVV'],
	  				:limit => c['Limite'],
	  				:used_credit => c['Saldo Consumido'],
	  				:card_wallet => get_user_wallet(token)
			))
		end

		#passa o array de cartoes para a classe DAO persistir no banco
		message = ccards_dao.insert_credit_cards(card_array)
		message.to_json
 	end

	def remove_card(card_to_remove, token)
		if card_to_remove != nil
	 		#recupera a instancia da classe DAO
	 		ccards_dao = CreditCardDao.instance()
			message = ccards_dao.remove_card(card_to_remove['Numero do Cartao'] )
			
			#caso o novo limite maximo seja menor que o limite definido pelo usuario, 
	 		#alterar o limite para o novo limite maximo
			c_wallet_assist = CardWalletAssistance.instance()
	 		c_wallet_assist.adjust_max_wallet_limit(token)

			message.to_json
	  	end
	end

	def update_card(card_to_update, token)

		#recupera a instancia da classe DAO
		ccards_dao = CreditCardDao.instance()
 	
	  	if card_to_update != nil
	  		card = ccards_dao.get_card({:card_nr => card_to_update['Numero do Cartao']} )
	  		if card != nil
	  			if card_to_update['Nome Impresso']
	  				card.print_name = card_to_update['Nome Impresso']
	  			end
		
				if card_to_update['Dia de Cobranca']
					card.billing_date = card_to_update['Dia de Cobranca']
				end

				if card_to_update['Mes de Cobranca']
					card.billing_month = card_to_update['Mes de Cobranca']
				end

				if card_to_update['Mes de Expiracao']
					card.expire_month = card_to_update['Mes de Expiracao']
				end

				if card_to_update['Ano de Expiracao']
					card.expire_year = card_to_update['Ano de Expiracao']
				end

				if card_to_update['CVV']
					card.cvv = card_to_update['CVV']
				end
				
				if card_to_update['Limite']
					card.limit = card_to_update['Limite']
				end

				if card_to_update['Saldo Consumido']
					card.used_credit = card_to_update['Saldo Consumido']
				end

				message = ccards_dao.update_card(card)
				ccards_dao.update_card(card)

				#caso tenha ocorrido alteracao no limite
				if card_to_update['Limite']
					c_wallet_assist = CardWalletAssistance.instance()
					c_wallet_assist.adjust_max_wallet_limit(token)
				end
			else
				message = Array.new
				message.push({
					:errors => 'Cartao nao encontrado'
				})
			end
			message.to_json
		end
	end

	def get_user_wallet(token)
		user_dao = UserDao.instance()
		user = user_dao.get_user({:authentication_token => token})
		if user
			user.card_wallet
		end
	end
 end