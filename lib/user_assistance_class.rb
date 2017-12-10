require 'singleton'
require 'dao_classes/user_dao'

class UserAssistance
	include Singleton

	def list_users

		#recupera a instancia da classe DAO
		user_dao = UserDao.instance()


		#realiza a consulta ao banco
		all_users = user_dao.get_users()

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

		#recupera a instancia da classe DAO
		user_dao = UserDao.instance()

		#inicializa o array com as mensagens de resposta
	  	user_instances = Array.new

	  	#se no json veio apenas um usuario e nao uma lista de usuarios
	  	#inserir este usuario em um array para reaproveitar a logica de processamento
	  	if !parsed_json_users.is_a?(Array)
	  		parsed_json_users_arr = Array.new
	  		parsed_json_users_arr.push(parsed_json_users)
	  	else
	  		parsed_json_users_arr = parsed_json_users
	  	end

	  	#monta o array com as instancias dos usuarios que serao criados no banco
	  	parsed_json_users_arr.each do |u|
	  		user_instances.push(
	  			new_user = User.new(
	  				:first_name => u['Nome'].to_s,
	  				:last_name => u['Sobrenome'],
	  				:cpf => u['CPF'],
	  				:email => u['email'],
	  				:password => u['Senha'],
	  				:password_confirmation => u['Confirmacao Senha'],
	  				:card_wallet => CardWallet.new()
  				)
	  		)
	  	end
	  	message = user_dao.insert_users(user_instances)
	  	message.to_json
	end

	def remove_user(user_to_remove)

		#recupera a instancia da classe DAO
		user_dao = UserDao.instance()

	  	if user_to_remove != nil
	  		message = user_dao.remove_user(user_to_remove['email'])
	  		message.to_json
	  	end
	end

	def update_user(user_to_update)

		#recupera a instancia da classe DAO
		user_dao = UserDao.instance()

	  	if user_to_update != nil
	  		user = get_user(user_to_update['email'])
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
				message = user_dao.update_user(user)
			else
				message = Array.new
				message.push({
					:errors => 'Cartao nao encontrado'
				})
	  		end
	  	end
	  	message.to_json
	end
end
