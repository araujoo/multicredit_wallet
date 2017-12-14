 require 'singleton'
 require 'dao_classes/user_dao'

class CreditCardDao
	include Singleton

	def get_credit_cards(token)
		user_dao = UserDao.instance()
		user = user_dao.get_user({:authentication_token => token})
		if user
			user.card_wallet.credit_cards
		end
	end

	def insert_credit_cards(card_array)
	  	#inicializa o array com as mensagens de resposta
	  	message = Array.new

	  	card_array.each_with_index do |c, i|
  			if !c.valid?
				#em caso de falha, retorna um JSON indicando qual foi o objeto da lista de cartoes
				#que falhou e quais foram os erros que impossibilitaram o cadastramento
				message.push({
					:object => "#{i+1}",
					:errors => c.errors.messages
				})
			else
				if c.save
					message.push({
						:object => "#{i+1}",
						:message => "Cartao de nr \"#{c.card_nr}\" foi cadastrado com sucesso "
					})
				else
					message.push({
						:object => "#{i+1}",
						:error => "Falha ao gravar cartão \"#{c.card_nr}\""
					})
				end
			end
		
		end
		message
	end

	def remove_card(card_nr)
		#inicializa array de mensagens
		message = Array.new

  		card = get_card({:card_nr => card_nr})
  		if card != nil
			if card.delete
				message.push({
					:message => "Cartao #{card_nr} removido com sucesso"
				})
			else
				message.push({
					:error => "Falha ao remover o cartao #{card_nr}"
				})					
			end
		else
			message.push({
				:errors => 'Cartao nao encontrado'
			})				
  		end
		message
	end

	def update_card(card_to_update)

		#inicializa o array de mensagens
		message = Array.new

		if !card_to_update.valid?
			message.push({
				:errors => card_to_update.errors.messages
			})
		else
			if card_to_update.save
				message.push({
					:message => "Dados do cartao #{card_to_update['card_nr']} atualizados com sucesso"
				})
			else
				message.push({
					:error => "Falha ao atualizar os dados do cartao #{card_to_update['card_nr']}"
				})
			end
		end
	end
	
	def get_card(param_hash)
		CreditCard.where(param_hash).first
	end

end