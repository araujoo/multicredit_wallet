require 'test_helper'
Devise::Test::ControllerHelpers
class UpdatingCardTest < ActionDispatch::IntegrationTest
	setup do
		User.create( :first_name => "Teste1",
				 	 :last_name => "Teste1 Sobrenome",
					 :cpf => "11144477as2",
					 :email => "teste@teste.com.br",
					 :password => 'abc',
					 :password_confirmation => 'abc'
					 #:password_digest => '95da2cff12b2d1c9fa7053f78b520e6b9bb5f6fe1dde687b7c7c196f4e619d6b'
				   )
	end
	test 'updating cards' do
		#request.header['HTTP_AUTH_TOKEN'] = '95da2cff12b2d1c9fa7053f78b520e6b9bb5f6fe1dde687b7c7c196f4e619d6b'
		put '/credit_cards/update_card', authenticate: {"HTTP_AUTH_TOKEN" => "95da2cff12b2d1c9fa7053f78b520e6b9bb5f6fe1dde687b7c7c196f4e619d6b"},
		params: {
				card_nr: "1234567890112233",
				print_name: "Oberdan Araujo", 
				billing_date: "07/07", 
				expire_date: "07/2016", 
				cvv: "123", 
				limit: "2000.00"
			}.to_json

		assert_equal 200, response.status
		assert_equal Mime[:json], response.content_type
	end

end
