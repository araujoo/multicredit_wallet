require 'singleton'
require 'dao_classes/credit_card_dao'
require 'bigdecimal/util'
require 'card_wallet_assitance_class'
require 'application_assistance'
class PurchaseAssistance
	include Singleton
	
	def get_cards_for_payment(token)
		card_wallet_assistance = CardWalletAssistance.instance()
		application_assistance = ApplicationAssistance.instance()

		card_wallet = card_wallet_assistance.get_wallet(token)

		credit_cards = card_wallet.credit_cards
		credit_cards.sort_by{ |card| [-(application_assistance.calc_days_difference(card.billing_date)), (card.limit.to_d.truncate(2).to_f - card.used_credit.to_d.truncate(2).to_f)]}
	end

	def buy(token, value)
		begin
			card_wallet = card_wallet_assistance = CardWalletAssistance.instance()
			limit = card_wallet.get_spendable_lim(token)
			if value.to_d.truncate(2).to_f > limit.to_d.truncate(2).to_f
				message = 'Valor da Compra Excede limite disponivel'
			else
				#cria objeto de registro de compra
				purchase = Purchase.new()
				purchase.value = value
				cards_for_payment = get_cards_for_payment(token)
				remaining_value = value
				cards_for_payment.each do |c|
					#se o cartao consumiu todo o limite, busca o proximo cartao para realizar a compra
					if c.limit == c.used_credit
						next
					end
					#efetua o pagamento
					remaining_value = execute_payment(remaining_value, c, true)

					#guarda o cartao de credito que foi utilizado para compra
					purchase.credit_cards.push(c)
					if remaining_value <= 0.0
						break
					end
				end
				if purchase.changed? && purchase.valid?
					purchase.save
				end
				message = 'Pagamento realizado com sucesso'
			end
		rescue
			message = 'Valor invalido'
		end
	end

	def execute_payment(value, card, share_value_with_other_cards)
		remaining_value = (value.to_d.truncate(2).to_f + card.used_credit.to_d.truncate(2).to_f - card.limit.to_d.truncate(2).to_f)
		card_dao = CreditCardDao.instance()
		if remaining_value <= 0.0
			card.used_credit = (value.to_d.truncate(2).to_f + card.used_credit.to_d.truncate(2).to_f).to_s
		elsif share_value_with_other_cards
			card.used_credit = card.limit
		end
		card_dao.update_card(card)
		remaining_value
	end

	def antecipate_payment(token, card_nr, value, share_value_with_other_cards)
		card_dao = CreditCardDao.instance()
		card = card_dao.get_card(token, {:card_nr => card_nr})
		if card
			begin
				value = '-' + value
				if execute_payment(value, card, false) <= 0.0
					message = 'Pagamento realizado com sucesso'
				else
					message = 'Valor da Compra Excede limite disponivel'
				end
			rescue
				message = 'Valor invalido'
			end
		else
			message = 'Cartao Nao Encontrado'
		end
	end
end