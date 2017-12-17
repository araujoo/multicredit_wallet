require 'purchase_assistance_class'
require 'application_assistance'

class PurchasesController < ApplicationController
	before_action :check_user_auth, except: [:sign_in, :add_users]

	def antecipate_payment
		purchase_assistance = PurchaseAssistance.instance()
		render json: purchase_assistance.antecipate_payment(request.headers["HTTP_AUTH_TOKEN"], params["Numero do Cartao"], params["Valor a Pagar"], false), status: 200
	end

	def buy
		value = params["Valor"]
		purchase_assistance = PurchaseAssistance.instance()
		render json: purchase_assistance.buy(request.headers["HTTP_AUTH_TOKEN"], value), status: 200
	end

	private
	def check_user_auth
		app_assist = ApplicationAssistance.instance()
		if !app_assist.check_user_auth(request.headers["HTTP_AUTH_TOKEN"])
			render json: 'Usuario nao autenticado', status: 401
		end
	end	
end
