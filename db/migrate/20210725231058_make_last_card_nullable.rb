class MakeLastCardNullable < ActiveRecord::Migration[6.1]
  def change
    change_column :decks, :last_card, :string, null: true
  end
end
