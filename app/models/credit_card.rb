class CreditCard < ApplicationRecord

      belongs_to :card_wallet

#      #numero do cartao
      validates :card_nr, presence: { message: 'Campo "Numero do Cartao" e de preenchimento obrigatorio' }
      validates :card_nr, uniqueness: { message: "Cartao \"%{value}\" ja cadastrado" }
      validates :card_nr, length: { is: 16, message: 'O campo Numero do Cartao deve conter exatamente 16 digitos' }
      validates :card_nr, numericality: { only_integer: { message: 'Campo "Numero do Cartao" deve conter apenas numeros' } }

      #nome impresso no cartao
      validates :print_name, presence: { message: 'Campo "Nome Impresso" e de preenchimento obrigatorio' }
      validates :print_name, length: { in: 5..30, message: 'Campo "Nome Impresso" deve conter no minimo 5 letras e no maximo 30' }

      #data de cobranca
      validates :billing_date, presence: { message: 'Campo "Data de Cobranca" e de preenchimento obrigatorio' }
      validates :billing_date, numericality: { only_integer: { message: 'Campo "Data de Cobranca" deve conter apenas numeros' } }
      validates :billing_month, presence: { message: 'Campo "Mes de Cobranca" e de preenchimento obrigatorio' }
      validates :billing_month, numericality: { only_integer: { message: 'Campo "Mes de Cobranca" deve conter apenas numeros' } }

      #data de validade
      validates :expire_month, presence: { message: 'Campo "Mes de Expiracao" e de preenchimento obrigatorio' }
      validates :expire_month, numericality: { only_integer: { message: 'Campo "Mes de Expiracao" deve conter apenas numeros' } }
      validates :expire_year, presence: { message: 'Campo "Mes de Expiracao" e de preenchimento obrigatorio' }
      validates :expire_year, numericality: { only_integer: { message: 'Campo "Ano de Expiracao" deve conter apenas numeros' } }
      validate :expire_date_must_not_be_in_past
      validate :expire_date_must_be_valid_date

      #cvv
      validates :cvv, presence: { message: 'Campo "CVV" e de preenchimento obrigatorio' }
      validates :cvv, length: { is: 3, message: 'Campo "CVV" deve conter 3 numeros' }
      validates :cvv, numericality: { only_integer: { message: 'Campo "CVV" deve conter apenas numeros' } }

      #limite
      validates :limit, presence: { message: 'Campo "limit" e de preenchimento obrigatorio' }
      validates_format_of :limit, :with => /(\A(\.|[0-9]*\.))[0-9]{2}\z/, :message => 'Campo "Limite" invalido. Favor inserir um valor no formato "123.00"'

      def expire_date_must_be_valid_date
            begin
                  #a classe Time aceita ano negativo. necessario inserir uma validacao custom neste ponto
                  if expire_year != nil && expire_month != nil
                        if expire_year < 0
                              errors.add(:expire_year, 'Ano nao deve ser negativo')      
                        else
                              Time.new(expire_year, expire_month)
                        end
                  end
                  
            rescue
                  errors.add(:expire_month, 'Data invalida. Favor insira uma data valida')
            end
      end


      def expire_date_must_not_be_in_past
            today_year = Date.today.year.to_i
            if ((expire_year != nil && expire_month != nil) && ( expire_year <= Date.today.year || ( expire_year == Date.today.year && expire_month <= Date.today.month)) ) 
                  errors.add(:expire_year, " today_year = #{today_year} ano = #{expire_year} expire_month = #{expire_month} Date.today.year = #{Date.today.year}, Date.today.month = #{Date.today.month} Ano ou mês no passado. Favor inserir ano e mes no futuro")
                  errors.add(:expire_month, 'Ano ou mês no passado. Favor inserir ano e mes no futuro')
            end
      end
end