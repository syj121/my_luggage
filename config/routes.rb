Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 
  root "devises/sessions#new"

  namespace :admin do
    get "/" => "admin#index"
    get "/home" => "home#index"

  end

end
