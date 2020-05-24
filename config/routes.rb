Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get "portfolio", to: "users#portfolio"
  get "search_stocks", to: "stocks#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
