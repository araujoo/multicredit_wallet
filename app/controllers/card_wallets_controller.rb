require 'card_wallet_assitance_class'
require 'application_assistance'

class CardWalletsController < ApplicationController
	
	before_action :check_user_auth

	def update_limit
		#recupera o JSON enviado no corpo da requisicao
	  	card_wallet_assistance = CardWalletAssistance.instance()
	  	result = card_wallet_assistance.update_limit(params['Limite'], request.headers["HTTP_AUTH_TOKEN"])
	  	render json: result[:text], status: result[:status]
	end
	def read_limit
	  	card_wallet_assistance = CardWalletAssistance.instance()
	  	limit = "Limite" + card_wallet_assistance.read_limit(request.headers["HTTP_AUTH_TOKEN"])
		render json: limit , status: 200
	end

	private
	def check_user_auth
		app_assist = ApplicationAssistance.instance()
		if !app_assist.check_user_auth(request.headers["HTTP_AUTH_TOKEN"])
			render json: 'Usuario nao autenticado', status: 401
		end
	end
end
