Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#index"
  resources :posts , only: [:index, :new, :create]
  resources :profiles , only: [:index, :new, :create]
end
