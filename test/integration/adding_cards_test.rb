require 'test_helper'

class AddingCardsTest < ActionDispatch::IntegrationTest
	test 'adding cards' do 

		post "/credit_cards/add_card", 
		params: [
			{
				card_nr: "1234567890112233",
				print_name: "Oberdan Araujo", 
				billing_date: "07/07", 
				expire_date: "07/2016", 
				cvv: "123", 
				limit: "2000.00"
			}		].to_json

		assert_equal 201, response.status
		assert_equal Mime[:json], response.content_type
	end
end

