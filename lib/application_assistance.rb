require 'singleton'
require 'dao_classes/user_dao'

class ApplicationAssistance < ApplicationController

	include Singleton

	def generate_token
		(Devise.token_generator.generate(User, :authentication_token))[1]
	end

	def sign_in(email, password)
		user_dao = UserDao.instance()
		user = user_dao.get_user({:email => email})
		if !user || (user && !user.valid_password?(password))
			text = 'Usuario ou senha invalidos'
			status = 400
		elsif user.authentication_token != nil
			text = 'Usuario ja autenticado'
			status = 200
		else user.valid_password?(password)
			user.authentication_token = generate_token
			user_dao.update_user(user)
			text = 'Token' + ' ' + user.authentication_token
			status = 200
		end
		{:message => text, :status => status}
	end

	def sign_out(token)
		if token
			user_dao = UserDao.instance()
			user = user_dao.get_user({:authentication_token => token})
			if user
				user.authentication_token = nil
				user_dao.update_user(user)
				text = 'Logout realizado com sucesso'
				status = 200
			else
				text = 'Nao foi possivel realizar o logout'
				status = 404
			end
		else
			text = 'Nao foi possivel realizar o logout'
			status = 404
		end
		{:message => text, :status => status}
	end	

    def check_user_auth(token)
        user_dao = UserDao.instance()
        if token && user_dao.get_user({:authentication_token => token})
        	true
       	else
       		false
    	end
    end

    def calc_days_difference(day)
    	today = Date.today
    	date_to_calc = Date.parse("#{today.year}-#{today.month}-#{day}")
    	
    	#se a data estiver no passado, realizar a avaliacao considerando o mes seguinte.
    	#caso o mes fique maior que 12, setar o mes para janeiro e avaliar considerando virada de ano
    	if date_to_calc.past?
    		begin 
    			date_to_calc = Date.parse("#{today.year}-#{today.month+1}-#{day}")
    		rescue
    			date_to_calc = Date.parse("#{today.year+1}-01-#{day}")		
    		end
    	end
    	((date_to_calc - today).to_i).abs
    end

end
