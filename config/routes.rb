Rails.application.routes.draw do
  resources :decks, only: %i[create destroy update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
