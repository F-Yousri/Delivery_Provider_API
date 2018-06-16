Rails.application.routes.draw do
  
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/api/v1/orders', to: 'orders#show'
  post '/registerdriver' ,to: 'drivers#create'
  post '/api/v1/authentication/drivers/signin' ,to: 'authentication#authenticate'
  post '/api/v1/authentication/drivers/update' ,to: 'drivers#update'
  post '/api/v1/drivers/registertoken' ,to: 'drivers#reg_token'
  post '/api/v1/authentication/drivers/signout' ,to: 'drivers#signout'
  post '/api/v1/authentication/getvehicle', to: 'vehicles#get_vehicle'
  post '/api/v1/authentication/users/signin', to: 'authentication_user#authenticate'
  post '/registeruser' ,to: 'users#create'
end
