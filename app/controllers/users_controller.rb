require 'user_assistance_class'
require 'application_assistance'
	
class UsersController < ApplicationController
	before_action :check_user_auth, except: [:sign_in, :add_users]

	def list_users
		
		#recupera a instancia da classe de assistencia para o escopo de usuario
	  	user_assistance = UserAssistance.instance()
	  	render json:user_assistance.list_users, status: 200
	end

	def add_users

	  	#recupera o JSON enviado no corpo da requisicao
	  	users = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de usuario
	  	user_assistance = UserAssistance.instance()

	  	#realiza o processo de insercao do usuario atraves da classe de assistencia,
	  	#retornando, via json, o resultado da operacao de adicao de usuario
	  	render json: user_assistance.add_users(users), status: 201
	  	#render json: request.headers["HTTP_AUTH_TOKEN"].to_json, status: 201
	end

	def remove_user
		#recupera o JSON enviado no corpo da requisicao
	  	user_to_remove = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de usuario
	  	user_assistance = UserAssistance.instance()
		render json: user_assistance.remove_user(user_to_remove), status: 200
	end

	def update_user
	  	#recupera a instancia da classe de assistencia para o escopo de usuario
	  	user_assistance = UserAssistance.instance()
		render json: user_assistance.update_user(user), status: 200
	end

	def sign_in
		email = params[:email]
		password = params[:Senha]
		app_assist = ApplicationAssistance.instance()
		result = app_assist.sign_in(email, password)
		render json: result[:message], status: result[:status]
	end

	def sign_out
		app_assist = ApplicationAssistance.instance()
		result = app_assist.sign_out(request.headers["HTTP_AUTH_TOKEN"])
		render json: result[:message], status: result[:status]
	end

	private
	def check_user_auth
		app_assist = ApplicationAssistance.instance()
		if !app_assist.check_user_auth(request.headers["HTTP_AUTH_TOKEN"])
			render json: 'Usuario nao autenticado', status: 401
		end
	end
end
