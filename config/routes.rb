Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "officers#login"


  get "officers/login"
  post "officers/attemptLogin"
  get "officers/logout"
  get "officers/newPointEntry"
  post "officers/processNewPointEntry"

  get "members/newPointEntry"
  get "members/loadAttendanceData"
  post "members/processNewPointEntry"
  get "members/login"
  post "members/attemptLogin"
  get "members/show_member"
  get "members/logout"

  get "point_entries/view"
  get "point_entries/index"

  #leaderboard routes
  get "leaderboard/view"
  post "leaderboard/view"

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
