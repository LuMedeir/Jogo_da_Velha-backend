Rails.application.routes.draw do
  resources :games, only: [:create, :show, :update, :destroy] do
    member do
      patch :move
      patch :reset
    end
  end
end