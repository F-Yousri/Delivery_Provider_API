Rails.application.routes.draw do
  
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'orders', to: 'orders#show'
  post 'registerdriver' ,to: 'drivers#create'
  post '/api/v1/authentication/drivers/signin' ,to: 'authentication#authenticate'
  
end
