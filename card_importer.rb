#!/usr/local/bin/ruby

# Parses decks from the MTG official website
# Usage:
# ruby card_fetcher.rb 'Goblin Piledriver'

require 'sqlite3'

require_relative 'lib/card'
require_relative 'lib/card_db'

card_list = ARGV[0]

unless card_list
  abort 'Usage: card_importer.rb cardlist.txt'
end

card_db = CardDB.new
card_db.connect_to_db

card_text = ''
cards = []
File.open(card_list).each_line do |line|
  line.chomp!
  if line.empty? then
    unless card_text.empty? then
      #card = Card.new(card_text)
      #puts card.name
      #card_db.add_card(card)
      cards << Card.new(card_text)
    end
    card_text = ''
  else
    card_text << line.to_s + "\n"
  end

end

card_db.add_many_cards cards

