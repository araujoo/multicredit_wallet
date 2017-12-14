require 'credit_card_assistance_class'
require 'application_assistance'

class CreditCardsController < ApplicationController
	
	before_action :check_user_auth

    def list_cards
		#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	ccard_assistance = CreditCardAssistance.instance()
	  	render json: ccard_assistance.list_cards(request.headers["HTTP_AUTH_TOKEN"]), status: 200
	end

	def add_card

	  	#recupera o JSON enviado no corpo da requisicao
	  	cards = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	ccard_assistance = CreditCardAssistance.instance()

	  	#realiza o processo de insercao do cartao de credito atraves da classe de assistencia,
	  	#retornando, via json, o resultado da operacao de adicao de cartao de credito
	  	render json: ccard_assistance.add_cards(cards, request.headers["HTTP_AUTH_TOKEN"]), status: 201
	end

	def remove_card
		#recupera o JSON enviado no corpo da requisicao
	  	card_to_remove = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	ccard_assistance = CreditCardAssistance.instance()
		render json: ccard_assistance.remove_card(card_to_remove, request.headers["HTTP_AUTH_TOKEN"]), status: 200
	end

	def update_card
		#recupera o JSON enviado no corpo da requisicao
	  	card = JSON.parse(request.raw_post)

	  	#recupera a instancia da classe de assistencia para o escopo de cartoes de credito
	  	ccard_assistance = CreditCardAssistance.instance()
		render json: ccard_assistance.update_card(card, request.headers["HTTP_AUTH_TOKEN"]), status: 200
	end

	private
	def check_user_auth
		app_assist = ApplicationAssistance.instance()
		if !app_assist.check_user_auth(request.headers["HTTP_AUTH_TOKEN"])
			render json: 'Usuario nao autenticado', status: 401
		end
	end

end