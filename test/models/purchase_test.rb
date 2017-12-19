require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  
	test 'value should not be negative' do
		p = Purchase.new()
		p.value = "-1.00"
		p.card_wallet = CardWallet.new()

		if p.value.to_d.truncate(2).to_f < 0.0
			assert !p.valid?
		end
	end
end
