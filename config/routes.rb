Rails.application.routes.draw do
  resources :decks, only: %i[create show destroy update]
  match 'decks/:id/shuffle/', via: %i[get post], to: 'decks#shuffle'
  match 'decks/:id/draw/', via: %i[get post], to: 'decks#draw'
  match 'decks/:id/draw/:count', via: %i[get post], to: 'decks#draw'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
