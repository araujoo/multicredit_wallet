 require 'singleton'

 class CreditCardAssistance
 	include Singleton

	def list_cards
		
		#realiza a consulta ao banco
		credit_cards = CreditCard.all

		#inicializa o dado de retorno
		user_cards = Array.new

		credit_cards.each do |c|
			user_cards.push({
				"Número do Cartão" => "#{c.card_nr}",
				"Nome Impresso no Cartão" => "#{c.print_name}",
				"Data de Vencimento" => "#{c.billing_date}\/#{c.billing_month}",
				"Validade do Cartão" => "#{c.expire_month}\/#{c.expire_year}",
				"CVV" => "#{c.cvv}",
				"Limite do Cartão" => "#{sprintf "%.2f", ((c.limit.to_f)/100)}",
				"Cadastrado no dia" => "#{c.created_at}",
				"Atualizado no dia" => "#{c.updated_at}",
				"Saldo Atual :" => "#{sprintf "%.2f", ((c.current_balance.to_f)/100)}"
			})			
		end
		
		credit_cards_json = user_cards.to_json
		credit_cards_json
	end


 	def add_cards(parsed_json_cards)
	  	#inicializa o array com as mensagens de resposta
	  	message = Array.new

	  	#se foi recebido apenas um cartao, e nao um array de objetos,
	  	#adicionar o objeto a um array para que a logica de processamento
	  	#seja heterogenea
	  	if !parsed_json_cards.is_a?(Array)
	  		parsed_json_cards_arr = Array.new
	  		parsed_json_cards_arr.push(parsed_json_cards)
	  	else
	  		parsed_json_cards_arr = parsed_json_cards
	  	end


	  	#inicializa o buffer de criacao de novo cartao
	  	new_credit_card = 0
	  	parsed_json_cards_arr.each_with_index do |c, i|
	  		
	  		#testa para ver se o limite do cartao de credito esta no formato adequado
	  		#caso contrario, exibe a mensagem de erro
	  		
  			new_credit_card = CreditCard.new(
  				:card_nr => c['Numero Cartao'].to_s,
  				:print_name => c['Nome Impresso'],
  				:billing_date => c['Dia de Cobranca'],
  				:billing_month => c['Mes de Cobranca'],
  				:expire_month => c['Mes de Expiracao'],
  				:expire_year => c['Ano de Expiracao'],
  				:cvv => c['CVV'],
  				:limit => "#{(c['Limite'].to_f.truncate(3)*100).to_i}",
  				:current_balance => "#{(c['Limite'].to_f.truncate(3)*100).to_i}"
  			)

  			if !new_credit_card.valid?
				#em caso de falha, retorna um JSON indicando qual foi o objeto da lista de cartoes
				#que falhou e quais foram os erros que impossibilitaram o cadastramento
				message.push({
					:object => "#{i+1}",
					:errors => new_credit_card.errors.messages
				})
			else
	  			str_limit = c['Limite']
		  		if str_limit && !str_limit.match('(^(\.|[0-9]*\.))[0-9]{2}$')
		  			new_credit_card.errors.add(:limit, 'Campo "Limite" invalido. Favor inserir um valor no formato "123.00"')
		  			message.push({
						:object => "#{i+1}",
						:errors => new_credit_card.errors.messages
					})
					#amarra o erro na estrutura de erros e passa para proxima iteracao
					next
				elsif !str_limit
					new_credit_card.errors.add(:limit, 'Campo "Limite" invalido é preenchimento obrigatorio')
		  			message.push({
						:object => "#{i+1}",
						:errors => new_credit_card.errors.messages
					})
		  			#amarra o erro na estrutura de erros e passa para proxima iteracao
					next
			  	
				else
					if new_credit_card.save
						message.push({
							:object => "#{i+1}",
							:message => "Cartao de nr \"#{c['Numero Cartao']}\" foi cadastrado com sucesso "
						})
					else
						message.push({
							:object => "#{i+1}",
							:error => "Falha ao gravar cartão \"#{c['Numero Cartao']}\""
						})
					end
				end
			end
		
		end
		message.to_json
 	end

	def remove_card(card_to_remove)

		#inicializa array de mensagens
		message = Array.new

	  	if card_to_remove != nil
	  		card = CreditCard.find_by( :card_nr => card_to_remove['Numero Cartao'] )
	  		if card != nil
				if card.delete
					message.push({
						:message => "Cartao #{card_to_remove['Numero Cartao']} removido com sucesso"
					})
				else
					message.push({
						:error => "Falha ao remover o cartao #{card_to_remove['Numero Cartao']}"
					})					
				end
			else
				message.push({
					:errors => 'Cartao nao encontrado'
				})				
	  		end
	  	end
		message.to_json
	end

	def update_card(card_to_update)

		#inicializa o array com os objetos falhos
		message = Array.new

	  	if card_to_update != nil
	  		card = CreditCard.find_by( :card_nr => card_to_update['Numero Cartao'] )
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
					card.limit = "#{(card_to_update['Limite'].to_f.truncate(3)*100).to_i}"
				end

				if !card.valid?
					message.push({
						:errors => card.errors.messages
					})
				else
					if card.save
						message.push({
							:message => "Salvei! Dados do cartao #{card_to_update['card_nr']} atualizados com sucesso"
						})
					else
						message.push({
							:error => "Falha ao atualizar os dados do cartao #{card_to_update['card_nr']}"
						})
					end
				end
			else
				message.push({
					:errors => 'Cartao nao encontrado'
				})
	  		end
	  	end
	  	message.to_json
	end
 end