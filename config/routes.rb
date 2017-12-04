Rails.application.routes.draw do
  get 'credit_cards/list_cards'
  post 'credit_cards/add_card'
  delete 'credit_cards/remove_card'
  put 'credit_cards/update_card'

  get 'users/list_users'
  post 'users/add_users'
  delete 'users/remove_user'
  put 'users/update_user'    
end
