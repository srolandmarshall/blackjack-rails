class DeckLastCardShouldBeHash < ActiveRecord::Migration[6.1]
  def change
    remove_column :decks, :last_card
    add_column :decks, :last_card, :json, default: {}
  end
end
