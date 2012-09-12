#!/usr/local/bin/ruby

# Parses decks from the MTG official website
# Usage:
# ruby deck_parser.rb 'http://www.wizards.com/Magic/Magazine/Article.aspx?x=mtg/daily/eventcoverage/wmc12/all_decklists'

require 'nokogiri'
require 'open-uri'


# For testing purposes
input_files = ['http://www.wizards.com/Magic/Magazine/Article.aspx?x=mtg/daily/eventcoverage/wmc12/all_decklists']

link_name_match = 'magic/(.*)?.*'
link_prefix = 'http://www.wizards.com'

for i in input_files do
	doc = Nokogiri::HTML(open(i))
	decks = doc.css('div[class = "dekoptions"] > a')
	links = decks.map{ |d| d.attribute('href').to_s }

	links.each do |link|
		link_name = link.sub( /\/magic\/(.*)\?.*/, '\1')
		link_path = link_prefix + link
		print "Downloading #{link}\n";
		outfile = open( link_name, 'wb' )
		outfile.write(open(link_path).read)
		outfile.close
	end
end
