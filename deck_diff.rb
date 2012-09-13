#!/usr/local/bin/ruby

# Spits out a diff of two decks.
# Usage: deck_diff.rb '1.dek' '2.dek'

require_relative 'lib/deck'

(deck_1, deck_2) = ARGV

unless deck_1 and deck_2
  abort 'Usage: deck_diff.rb 1.dek 2.dek'
end

d1 = Deck.new
d1.load_mtgo_format File::open(deck_1).read
d2 = Deck.new
d2.load_mtgo_format File::open(deck_2).read

diff = d1.diff d2

keys = diff.keys.sort { |a, b| diff[a] <=> diff[b] }
keys.each do |k|
  printf "%+d %s\n", diff[k], k
end
