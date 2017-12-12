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
		if !user 
			text = 'Usuario ou senha invalidos'
			status = 401
		elsif user.authentication_token != nil
			text = 'Usuario ja autenticado'
			status = 200
		elsif user.valid_password?(password)
			user.authentication_token = generate_token
			user_dao.update_user(user)
			text = 'Token' + user.authentication_token
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
	end	

    def check_user_auth(token)
        user_dao = UserDao.instance()
        if token && user_dao.get_user({:authentication_token => token})
        	true
       	else
       		false
    	end
    end
end
