Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'

  post 'loans', to: 'loans#create'
  put 'loans/:id/approve', to: 'loans#approve'
  get 'loans', to: 'loans#index'
  get 'loans/:id', to: 'loans#view'

  get 'loans/:id/repayments', to: 'repayments#index'
  post 'loans/:id/repay', to: 'repayments#add_payment'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
