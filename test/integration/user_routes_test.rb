require 'test_helper'

class UserRoutesTest < ActionDispatch::IntegrationTest
	test 'list users' do

		get '/users/list_users'

		assert_equal 200, response.status
		assert_equal Mime[:json], response.content_type
	end

	test 'creating users' do 

		post "/sign_up", 
		params: [{
			:first_name => "Teste1",
			:last_name => "Teste1 Sobrenome",
			:cpf => "11144477as2",
			:email => "teste@teste.com.br",
			:password => 'abc',
			:password_confirmation => 'abc'
		}].to_json

		assert_equal 201, response.status
		assert_equal Mime[:json], response.content_type
	end

	test 'updating user' do
		put '/users/update_user',
		params: {
			:first_name => "Teste1",
			:last_name => "Teste1 Sobrenome",
			:cpf => "11144477as2",
			:email => "teste@teste.com.br",
			:password => 'abc',
			:password_confirmation => 'abc'
		}.to_json

		assert_equal 200, response.status
		assert_equal Mime[:json], response.content_type
	end

	test 'remove user' do
		delete '/users/remove_user',
		params: {
			:email => "teste@teste.com.br",
		}.to_json

		assert_equal 200, response.status
		assert_equal Mime[:json], response.content_type
	end

end
