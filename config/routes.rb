Rails.application.routes.draw do

  get 'credit_cards/list_cards'
  post 'credit_cards/add_card'
  delete 'credit_cards/remove_card'
  put 'credit_cards/update_card'

  get 'users/list_users'
  post 'sign_up', to: 'users#add_users'
  post 'sign_in', to: 'users#sign_in'
  put 'sign_out', to: 'users#sign_out'
  delete 'users/remove_user'
  put 'users/update_user'

  get 'card_wallets/read_limit'
  get 'card_wallets/read_available_credit'
  get 'card_wallets/read_max_lim_available'
  put 'card_wallets/update_limit'

end
