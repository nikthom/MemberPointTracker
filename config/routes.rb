Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "officers#login"

  get "officers/login"
  post "officers/attemptLogin"
  get "officers/logout"
  get "officers/newPointEntry"
  post "officers/processNewPointEntry"

  get "members/newPointEntry"
  post "members/processNewPointEntry"

  get "point_entries/view"
  get "point_entries/index"

  resources :officers do
    member do
      get :delete
      get :log
    end
  end

  resources :members do
    member do
      get :delete
      get :log
    end
  end

  get "/:page" => "static#show"

end
