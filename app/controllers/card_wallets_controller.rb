require 'card_wallet_assitance_class'
require 'application_assistance'

class CardWalletsController < ApplicationController
	
	before_action :check_user_auth

	def update_limit
	  	card_wallet_assistance = CardWalletAssistance.instance()
	  	result = card_wallet_assistance.update_limit(params['Limite'], request.headers["HTTP_AUTH_TOKEN"])
	  	render json: result[:text], status: result[:status]
	end

	def read_limit
	  	card_wallet_assistance = CardWalletAssistance.instance()
	  	limit = "Limite: " + card_wallet_assistance.read_limit(request.headers["HTTP_AUTH_TOKEN"])
		render json: limit.to_json , status: 200
	end

	def read_available_credit
	  	card_wallet_assistance = CardWalletAssistance.instance()
	  	limit = "Credito Disponivel: " + sprintf("%.2f", card_wallet_assistance.get_spendable_lim(request.headers["HTTP_AUTH_TOKEN"]))
		render json: limit.to_json , status: 200
	end

	def read_max_lim_available
	  	card_wallet_assistance = CardWalletAssistance.instance()
	  	limit = "Maior Limite Possivel: " + sprintf("%.2f", card_wallet_assistance.get_max_available_limit(request.headers["HTTP_AUTH_TOKEN"]))
		render json: limit.to_json , status: 200
	end	


	private
	def check_user_auth
		app_assist = ApplicationAssistance.instance()
		if !app_assist.check_user_auth(request.headers["HTTP_AUTH_TOKEN"])
			render json: 'Usuario nao autenticado', status: 401
		end
	end
end
