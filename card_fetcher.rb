#!/usr/local/bin/ruby

# Parses decks from the MTG official website
# Usage:
# ruby card_fetcher.rb 'Goblin Piledriver'

require 'nokogiri'
require 'open-uri'

require_relative 'lib/card'

# For testing purposes
input_cards = ARGV

unless input_files.any?
  abort 'Usage: card_fetcher.rb "name1" ["name2" ...]'
end


for i in 'Goblin Piledriver' do
#  doc = Nokogiri::HTML(open(i))
#  decks = doc.css('div[class = "dekoptions"] > a')
#  links = decks.map{ |d| d.attribute('href').to_s }
#
#  links.each do |link|
#    deck = Deck.new
#    link_name = link.sub( /\/magic\/(.*)\?.*/, '\1')
#    link_path = link_prefix + link
#    print "Downloading #{link}\n";
#    deck.load_mtgo_format( open(link_path).read )
#
#    outfile = open( link_name, 'wb' )
#    outfile.write( deck.to_s )
#    outfile.close
#  end
end
