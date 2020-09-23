Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "officers#new"
  
  resources :officers do
    member do
      get :delete
    end
  end
end
