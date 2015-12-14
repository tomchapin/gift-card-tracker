Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :gift_cards
  root to: 'gift_cards#index'
end
