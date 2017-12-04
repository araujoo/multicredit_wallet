class User < ApplicationRecord
	
	validates :first_name, presence: {message: "Campo \"Nome\" e de preenchimento obrigatorio"}
	
	validates :last_name, presence: {message: "Campo \"Sobrenome\" e de preenchimento obrigatorio"}
	
	validates :email, presence: {message: "Campo \"email\" e de preenchimento obrigatorio"}
	validates_format_of :email, :with => /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/, :message => 'Formato de email invalido. Favor insira um email valido'
	
	validates :cpf, presence: {message: "Campo \"CPF\" e de preenchimento obrigatorio"}
    validates :cpf, length: { is: 11, message: "Campo \"CPF\" deve conter 11 numeros" }
    validates :cpf, uniqueness: {message: "CPF \"%{value}\" ja cadastrado." }
    validates :cpf, numericality: { only_integer: { message: "Campo \"CPF\" deve conter apenas numeros" } }

	has_secure_password
	validates :password, presence: {:message => 'Campo "Senha" e de preenchimento obrigatorio'}
end
