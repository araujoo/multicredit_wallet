class User < ApplicationRecord
  # Include default devise modules.
	#acts_as_token_authenticatable

	has_one :card_wallet, dependent: :destroy
	has_many :purchases, dependent: :destroy

	validates :first_name, presence: {message: "Campo \"Nome\" e de preenchimento obrigatorio"}
	
	validates :last_name, presence: {message: "Campo \"Sobrenome\" e de preenchimento obrigatorio"}
	
	validates :email, presence: {message: "Campo \"email\" e de preenchimento obrigatorio"}
	validate :email, :unique_email, :on => :create
	validates_format_of :email, :with => /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/, :message => 'Formato de email invalido. Favor insira um email valido'
	
	validates :cpf, presence: {message: "Campo \"CPF\" e de preenchimento obrigatorio"}
    validates :cpf, length: { is: 11, message: "Campo \"CPF\" deve conter 11 numeros" }
    #validates :cpf, uniqueness: {message: "CPF \"%{value}\" ja cadastrado." }
    validates :cpf, numericality: { only_integer: { message: "Campo \"CPF\" deve conter apenas numeros" } }

    #essa validacao ja garante a falha caso o usuario nao informe senha
	has_secure_password

    def unique_email
    	if email != nil
    		user = User.find_by(:email => email)
    		if user != nil
    			errors.add(:cpf, "email \"#{email}\" ja cadastrado. Token:#{user.authentication_token}" )
    		end
    	end
    end



end
