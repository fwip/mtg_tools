#!/usr/local/bin/ruby

# Parses decks from the MTG official website
# Usage:
# ruby card_fetcher.rb 'Goblin Piledriver'

require 'nokogiri'
require 'open-uri'

require_relative 'lib/card'

# For testing purposes
input_cards = ARGV

unless input_cards.any?
  abort 'Usage: card_fetcher.rb "name1" ["name2" ...]'
end

testcard = "Goblin Piledriver
1R
Creature -- Goblin Warrior
1/2
Protection from blue
Whenever Goblin Piledriver attacks, it gets +2/+0 until end of turn for each other attacking Goblin.
ONS-R
"

print testcard + "\n"

card = Card.new testcard

print card

if (card.to_s == testcard)
  print "Hooray, they match!\n"
else
  abort "Oh no, they don't match. :(\n"
end
