class UsersController < ApplicationController
	require 'user_assistance_class'

	skip_before_action :verify_authenticity_token

	def list_users
		
		#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	user_assistance = UserAssistance.instance()
	  	render json:user_assistance.list_users, status: 200
	end

	def add_users

	  	#recupera o JSON enviado no corpo da requisicao
	  	users = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	user_assistance = UserAssistance.instance()

	  	#realiza o processo de insercao do cartao de credito atraves da classe de assistencia,
	  	#retornando, via json, o resultado da operacao de adicao de cartao de credito
	  	render json: user_assistance.add_users(users), status: 201
	end

	def remove_user
		#recupera o JSON enviado no corpo da requisicao
	  	user_to_remove = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	user_assistance = UserAssistance.instance()
		render json: user_assistance.remove_user(user_to_remove), status: 200
	end

	def update_user
		#recupera o JSON enviado no corpo da requisicao
	  	user = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	user_assistance = UserAssistance.instance()

		render json: user_assistance.update_user(user), status: 200
	end

end