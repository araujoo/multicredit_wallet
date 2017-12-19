#require 'test_helper'
#class UpdatingCardTest < ActionDispatch::IntegrationTest
#	test 'updating cards' do
#
#		put '/credit_cards/update_card',
#		params: {
#				card_nr: "1234567890112233",
#				print_name: "Oberdan Araujo", 
#				billing_date: "07/07", 
#				expire_date: "07/2016", 
#				cvv: "123", 
#				limit: "2000.00"
#			}.to_json
#
#		assert_equal 200, response.status
#		assert_equal Mime[:json], response.content_type
#	end
#
#end
