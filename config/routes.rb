Rails.application.routes.draw do

  resources :gift_cards do
    resources :transactions, only: [:create]
  end

  root to: 'gift_cards#index'

end
