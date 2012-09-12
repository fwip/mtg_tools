#!/usr/local/bin/ruby

# Parses decks from the MTG official website
# Usage:
# ruby deck_downloader.rb 'http://www.wizards.com/Magic/Magazine/Article.aspx?x=mtg/daily/eventcoverage/wmc12/all_decklists'

require 'nokogiri'
require 'open-uri'

require_relative 'lib/deck'

# For testing purposes
input_files = ARGV

unless input_files.any?
  abort 'Usage: deck_downloader.rb "url1" ["url2" ...]'
end

link_name_match = 'magic/(.*)?.*'
link_prefix = 'http://www.wizards.com'

for i in input_files do
  doc = Nokogiri::HTML(open(i))
  decks = doc.css('div[class = "dekoptions"] > a')
  links = decks.map{ |d| d.attribute('href').to_s }

  links.each do |link|
    deck = Deck.new
    link_name = link.sub( /\/magic\/(.*)\?.*/, '\1')
    link_path = link_prefix + link
    print "Downloading #{link}\n";
    deck.load_mtgo_format( open(link_path).read )

    outfile = open( link_name, 'wb' )
    outfile.write( deck.to_s )
    outfile.close
  end
end
