 require 'singleton'
 require 'dao_classes/user_dao'

class CardWalletDao
	include Singleton

	def get_card_wallet(token)
		user_dao = UserDao.instance()
		user = user_dao.get_user({:authentication_token => token})
		if user
			user.card_wallet
		end
	end

	def update_card_wallet(card_wallet)
		if card_wallet && card_wallet.valid?
			card_wallet.save
		end
	end
end