require 'card_wallet_assitance_class'

class CardWalletsController < ApplicationController
	def update_limit
		#recupera o JSON enviado no corpo da requisicao
	  	limit_to_update = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	card_wallet_assistance = CardWalletAssistance.instance()
		render json: ccard_assistance.update_limit(limit_to_update), status: 200
	end
	def read_limit
	  	card_wallet_assistance = CardWalletAssistance.instance()
		render json: card_wallet_assistance.read_limit, status: 200
	end
end
