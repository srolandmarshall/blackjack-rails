class DeckLastCardShouldBeHash < ActiveRecord::Migration[6.1]
  def change
    change_column :decks, :last_card, :json, default: {}
  end
end
