Rails.application.routes.draw do

  root to: "home#show"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"
  get '/dashboard', to: 'users#show'
  delete "/logout", to: "sessions#destroy", as: :logout

end
