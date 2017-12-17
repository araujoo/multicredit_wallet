#require 'test_helper'
#
#class UserRoutesTest < ActionDispatch::IntegrationTest
#	setup do
#		post '/sign_in', 
#			params: [{:email => "oberdan@oberdan.com.br",
#			:password => '123456'}].to_json
#	end
#
#	test 'list users' do
#
#		get '/users/list_users'
#
#		assert_equal 200, response.status
#		assert_equal Mime[:json], response.content_type
#	end
#
#	test 'creating users' do 
#
#		post "/sign_up", 
#		params: [{
#			:first_name => "Teste1",
#			:last_name => "Teste1 Sobrenome",
#			:cpf => "11144477as2",
#			:email => "teste@teste.com.br",
#			:password => 'abc',
#			:password_confirmation => 'abc'
#		}].to_json
#
#		assert_equal 201, response.status
#		assert_equal Mime[:json], response.content_type
#	end
#
#	test 'updating user' do
#		put '/users/update_user',
#		params: {
#			:first_name => "Teste1",
#			:last_name => "Teste1 Sobrenome",
#			:cpf => "11144477as2",
#			:email => "teste@teste.com.br",
#			:password => 'abc',
#			:password_confirmation => 'abc'
#		}.to_json, headers: { "HTTP_AUTH_TOKEN" => "95da2cff12b2d1c9fa7053f78b520e6b9bb5f6fe1dde687b7c7c196f4e619d6b" }
#
#		assert_equal 200, response.status
#		assert_equal Mime[:json], response.content_type
#	end
#
#	test 'remove user' do
#		delete '/users/remove_user',
#		params: {
#			:email => "teste@teste.com.br",
#		}.to_json
#
#		assert_equal 200, response.status
#		assert_equal Mime[:json], response.content_type
#	end
#
#end
