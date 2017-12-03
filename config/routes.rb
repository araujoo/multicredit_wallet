Rails.application.routes.draw do
  get 'credit_cards/list_cards'
  post 'credit_cards/add_card'
  delete 'credit_cards/remove_card'
  put 'credit_cards/update_card' 
end
