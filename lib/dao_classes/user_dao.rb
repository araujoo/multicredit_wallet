require 'singleton'

class UserDao
	include Singleton

	def get_users
		User.all
	end

	def insert_users(users_array)

		#inicializa o array com as mensagens de resultado
	  	message = Array.new

	  	users_array.each_with_index do |u, i|
  			if !u.valid?
				#em caso de falha, retorna um JSON indicando os usuarios que falharam na validacao
				#e quais obtiveram sucesso ao serem gravados no banco
				message.push({
					:object => "#{i+1}",
					:errors => u.errors.messages
				})
			else
				if u.save
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
		message
	end	

	def remove_user(email)

		#inicializa o array com as mensagens de resultado
	  	message = Array.new

		user = get_user({:email => email})
  		if user != nil
			if user.destroy
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
  		message
	end

	def update_user(user)
		
		#inicializa o array com as mensagens de resultado
	  	message = Array.new

		if !user.valid?
			message.push({
				:errors => user.errors.messages
			})
		else
			if !user.changed? or user.save
				message.push({
					:message => "Dados do cartao #{user['user_nr']} atualizados com sucesso"
				})
			else
				message.push({
					:error => "Falha ao atualizar os dados do cartao #{user['user_nr']}"
				})
			end
		end
	end


	def get_user(param_hash)
		User.where(param_hash).first
	end

end