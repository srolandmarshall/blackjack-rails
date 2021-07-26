class Deck < ApplicationRecord
  def self.create_with_api(decks, title = 'New Deck')
    @data = HTTParty.get("http://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=#{decks}")
    deck_id = @data['deck_id']
    remaining_cards = @data['remaining']
    @deck = Deck.new(deck_id: deck_id, remaining_cards: remaining_cards, title: title)
    @deck.save
  end

  def self.create_with_deck_id(deck_id, title = deck_id)
    @deck = Deck.new(deck_id: deck_id, title: title)
    @deck.save
  end

  def shuffle!
    url = "http://deckofcardsapi.com/api/deck/#{deck_id}/shuffle/"
    puts url
    puts "Shuffling deck #{deck_id}"

    response = HTTParty.get(url)
    self.remaining_cards = response['remaining']
    self.last_card = nil
    save
  end

  def fetch_deck_update
    response = HTTParty.get("http://deckofcardsapi.com/api/deck/#{deck_id}/")
    self.remaining_cards = response['remaining']
    save
  end

  def draw(num_cards)
    response = HTTParty.get("http://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=#{num_cards}")
    puts response.inspect
    self.remaining_cards = response['remaining']
    self.last_card = response['cards'].last
    save
  end
end
