class AddColumnsToDecks < ActiveRecord::Migration[6.1]
  def change
    add_column :decks, :remaining_cards, :integer, null: false, default: 0
    add_column :decks, :last_card, :integer, null: false, default: 0
  end
end
