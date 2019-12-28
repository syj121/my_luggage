Rails.application.routes.draw do
  
  #devise_for :users
  devise_for :users,controllers: {sessions: 'users/sessions'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "admin/admin#index"

  namespace :admin do
    get "/" => "admin#index"
    get "/home" => "home#index"

    resources :luggages do 
      member do 
        get :pay
        get :print
        get :save_charge
        get :show_charge
      end
    end

  end

end
