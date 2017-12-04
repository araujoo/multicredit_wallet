require 'singleton'
class UserAssistance
	include Singleton

	def list_users
		#realiza a consulta ao banco
		all_users = User.all

		#inicializa o dado de retorno
		users_response = Array.new

		all_users.each do |u|
			users_response.push({
				"Nome" => "#{u.first_name}",
				"Sobrenome" => "#{u.last_name}",
				"CPF" => "#{u.cpf}",
				"email" => "#{u.email}"
			})			
		end
		
		users_response_json = users_response.to_json
		users_response_json
	end

	def add_users(parsed_json_users)

		#inicializa o array com as mensagens de resposta
	  	message = Array.new

	  	#se no json veio apenas um usuario e nao uma lista de usuarios
	  	#inserir este usuario em um array para reaproveitar a logica de processamento
	  	if !parsed_json_users.is_a?(Array)
	  		parsed_json_users_arr = Array.new
	  		parsed_json_users_arr.push(parsed_json_users)
	  	else
	  		parsed_json_users_arr = parsed_json_users
	  	end

	  	#inicializa o buffer de criacao de novo usuario
	  	new_user = 0
	  	parsed_json_users_arr.each_with_index do |u, i|

  			new_user = User.new(
  				:first_name => u['Nome'].to_s,
  				:last_name => u['Sobrenome'],
  				:cpf => u['CPF'],
  				:email => u['email'],
  				:password => u['Senha'],
  				:password_confirmation => u['Confirmacao Senha'],
  			)

  			if !new_user.valid?
				#em caso de falha, retorna um JSON indicando os usuarios que falharam na validacao
				#e quais obtiveram sucesso ao serem gravados no banco
				message.push({
					:object => "#{i+1}",
					:errors => new_user.errors.messages
				})
			else
				if new_user.save
					message.push({
						:object => "#{i+1}",
						:message => "Usuario \"#{u['Nome']} #{u['Sobrenome']}\" foi cadastrado com sucesso "
					})
				else
					message.push({
						:object => "#{i+1}",
						:error => "Falha ao gravar usuario \"#{u['Nome']} #{u['Sobrenome']}\""
					})
				end
			end
		
		end
		message.to_json
	end

	def remove_user(user_to_remove)

		#inicializa array de mensagens
		message = Array.new

	  	if user_to_remove != nil
	  		user = User.find_by( :cpf => user_to_remove['CPF'] )
	  		if user != nil
				if user.delete
					message.push({
						:message => "Usuario #{user.first_name} #{user.last_name} removido com sucesso"
					})
				else
					message.push({
						:error => "Falha ao remover a o usuario #{user.first_name} #{user.last_name}"
					})					
				end
			else
				message.push({
					:errors => 'Usuario nao encontrado'
				})				
	  		end
	  	end
		message.to_json
	end

	def update_user(user_to_update)

		#inicializa o array com os objetos falhos
		message = Array.new

	  	if user_to_update != nil
	  		user = User.find_by( :CPF => user_to_update['CPF'] )
	  		if user != nil
	  			if user_to_update['Nome']
	  				user.first_name = user_to_update['Nome']
	  			end

				if user_to_update['Sobrenome']
					user.last_name = user_to_update['Sobrenome']
				end

				if user_to_update['email']
					user.email = user_to_update['email']
				end

				if !user.valid?
					message.push({
						:errors => user.errors.messages
					})
				else
					if user.save
						message.push({
							:message => "Dados do cartao #{user_to_update['user_nr']} atualizados com sucesso"
						})
					else
						message.push({
							:error => "Falha ao atualizar os dados do cartao #{user_to_update['user_nr']}"
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
