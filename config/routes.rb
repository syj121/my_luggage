Rails.application.routes.draw do
  
  #devise_for :users
  devise_for :users,controllers: {sessions: 'users/sessions'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 
  root "admin/admin#index"

  namespace :admin do
    get "/" => "admin#index"
    get "/home" => "home#index"

  end

end
