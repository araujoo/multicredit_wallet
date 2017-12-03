require 'test_helper'
require 'date'

class CreditCardTest < ActiveSupport::TestCase
	
	test 'should not be empty' do
		ccard = CreditCard.new( )
		assert !ccard.valid?
	end

	test 'card_nr should be unique' do
		ccard = CreditCard.new( 
			:card_nr => "1234123412341234",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)
		ccard.save
		ccard = CreditCard.new( 
			:card_nr => "1234123412341234",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end


	test 'should have card_nr' do
		ccard = CreditCard.new( 
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "07",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end

	test 'should have print_name' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:billing_date => "07",
			:billing_month => "07",
			:expire_month => "07",
			:expire_year => 2019,
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end

	test 'should have billing_date' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_month => "07",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end

	test 'should have billing_month' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end	

	test 'should have expire_month' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end


	test 'should have expire_year' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "07",
			:expire_month => "07",
			:cvv => "123",
			:limit => 200000
		)
		assert !ccard.valid?
	end

	test 'should have cvv' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "07",
			:expire_month => "07",
			:expire_year => "2019",
			:limit => 200000
		)
		assert !ccard.valid?
	end

	test 'should have limit' do
		ccard = CreditCard.new( 
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "07",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
		)
		assert !ccard.valid?
	end

	test 'print_name should have 5 to 30 chars' do
		ccard = CreditCard.new(
			:card_nr => "12345,67xbn890.112.233",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		)

		ccard.print_name = 'ala'
		if ( ccard.print_name != nil && ( ccard.print_name.length < 5 || ccard.print_name.length > 30 ))
			assert !ccard.valid?
		end
	end

	test 'cvv should have only 3 numbers' do
		ccard = CreditCard.new(
			:card_nr => "1234567890112233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2018",
			:limit => 200000
		 )
		ccard.cvv = "1234"
		if ccard.cvv.size < 3 || ccard.cvv.size > 3
			assert !ccard.valid?
		end

		ccard.cvv = "123a4"
		assert_no_match('[^0-9]', ccard.cvv)
	end

	test 'card_nr should have only numbers' do
		ccard = CreditCard.new(
			:card_nr => "12345,67xbn890.112.233",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		 )
		if !ccard.card_nr.match('[^0-9]')
			assert !ccard.valid?	
		end
	end

	test 'card_nr should have 16 digits' do
		ccard = CreditCard.new(
			:card_nr => "12345678901123",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2019",
			:cvv => "123",
			:limit => 200000
		 )
		if ccard.card_nr.size != 16
			assert !ccard.valid?
		end
	end

	test 'expire_date should not be in the past' do
		ccard = CreditCard.new(
			:card_nr => "1234567890112345",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "07",
			:expire_year => "2016",
			:cvv => "123",
			:limit => 200000
		 )

		assert !ccard.valid?
	end

	test 'expire_date_must_be_valid_date' do
		ccard = CreditCard.new(
			:card_nr => "1234567890112345",
			:print_name => "Oberdan Araujo",
			:billing_date => "07",
			:billing_month => "11",
			:expire_month => "17",
			:expire_year => "2018",
			:cvv => "123",
			:limit => 200000
		 )
			assert !ccard.valid?
	end
end