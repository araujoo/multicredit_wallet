require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test 'should not be empty' do
		user = User.new( )
		assert !user.valid?
	end

	test 'email should be unique' do
		user = User.new( 
			:first_name => "Teste1",
			:last_name => "Teste1 Sobrenome",
			:cpf => "11144477732",
			:email => "teste@teste.com.br",
			:password => 'abc',
			:password_confirmation => 'abc'
		)
		user.save

		user = User.new( 
			:first_name => "Teste2",
			:last_name => "Teste2 Sobrenome",
			:cpf => "11144477731",
			:email => "teste@teste.com.br",
			:password => 'abc',
			:password_confirmation => 'abc'
		)
		assert !user.valid?
	end

	test 'cpf should contain only numbers' do
		user = User.new( 
			:first_name => "Teste1",
			:last_name => "Teste1 Sobrenome",
			:cpf => "11144477as2",
			:email => "teste@teste.com.br",
			:password => 'abc',
			:password_confirmation => 'abc'
		)
		assert !user.valid?
	end

	test 'cpf should contain 11 numbers' do
		user = User.new( 
			:first_name => "Teste1",
			:last_name => "Teste1 Sobrenome",
			:cpf => "111444771796237171342",
			:email => "teste@teste.com.br",
			:password => 'abc',
			:password_confirmation => 'abc'
		)
		if user.cpf.length > 11 or user.cpf.length < 11 
			assert !user.valid?	
		end
	end

	test 'email should match valid format' do
		user = User.new( 
			:first_name => "Teste1",
			:last_name => "Teste1 Sobrenome",
			:cpf => "111444771796237171342",
			:email => "qwerty@qwerty@qwerty@qwerty",
			:password => 'abc',
			:password_confirmation => 'abc'
		)
		assert !user.valid?
	end
end