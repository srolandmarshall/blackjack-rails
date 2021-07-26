class CreateDecks < ActiveRecord::Migration[6.1]
  def change
    create_table :decks do |t|
      t.string :given_id
      t.string :name

      t.timestamps
    end
  end
end
