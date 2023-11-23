Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "login"  => "application#login",  as: :login
  get "logout" => "application#logout", as: :logout

  resources :posts, only: %i[ index create destroy ]

  root to: redirect("/posts")
end
