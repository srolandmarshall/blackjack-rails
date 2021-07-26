class ChangeDeckColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :decks, :name, :title
    rename_column :decks, :given_id, :deck_id
  end
end
