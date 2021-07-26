class Deck < ApplicationRecord
  def self.new_from_api(decks = 1, title = "Deck #{Time.now.strftime('%m%d%Y-%H%M%S')}")
    @data = HTTParty.get("http://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=#{decks}")
    deck_id = @data['deck_id']
    remaining_cards = @data['remaining']
    Deck.new(deck_id: deck_id, remaining_cards: remaining_cards, title: title)
  end

  def self.create_with_deck_id(deck_id, title = deck_id)
    @deck = Deck.new(deck_id: deck_id, title: title)
    @deck.save
  end

  def shuffle!
    puts "Shuffling deck #{deck_id}"
    url = "http://deckofcardsapi.com/api/deck/#{deck_id}/shuffle/"
    response = HTTParty.get(url)

    self.remaining_cards = response['remaining']
    self.last_card = {}
    save
    self
  end

  def fetch_deck_update
    response = HTTParty.get("http://deckofcardsapi.com/api/deck/#{deck_id}/")
    self.remaining_cards = response['remaining']
    save
  end

  def draw(num_cards)
    response = HTTParty.get("http://deckofcardsapi.com/api/deck/#{deck_id}/draw/?count=#{num_cards}")
    self.remaining_cards = response['remaining']
    self.last_card = response['cards'].last
    save
    response['cards']
  end

  # https://deckofcardsapi.com/api/deck/<<deck_id>>/pile/<<pile_name>>/add/?cards=AS,2S
  def add_to_pile(cards_hash, pile_name)
    cards = get_card_codes_string(cards_hash)
    url = "http://deckofcardsapi.com/api/deck/#{deck_id}/pile/#{pile_name}/add/?cards=#{cards}"
    response = HTTParty.get(url)
  end

  def draw_and_add_to_pile(num_cards, pile_name)
    cards = draw(num_cards)
    add_to_pile(cards, pile_name)
  end

  def piles
    url = "http://deckofcardsapi.com/api/deck/#{deck_id}/pile/_/list/"
    response = HTTParty.get(url)
    response['piles']
  end

  def pile_lookup(pile_name = '_')
    url = "http://deckofcardsapi.com/api/deck/#{deck_id}/pile/#{pile_name}/list/"
    response = HTTParty.get(url)
    response['piles'].select { |k, _v| k == pile_name }
  end

  def get_card_codes(cards)
    cards.map { |c| c['code'] }
  end

  def get_card_codes_string(cards)
    cards.map { |c| c['code'] }.join(',')
  end
end
