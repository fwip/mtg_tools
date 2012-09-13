class CardDB
  require 'sqlite3'
  require_relative 'card'
  @path = nil
  @db = nil

  def initialize (path = 'data/card.db')
    @path = path
    self.connect_to_db
  end


  def get_card (name)
    card = Card.new
    card_retrieve_text = <<-SQL
    SELECT name, cost, type, supertype, subtypes, power, toughness, text,
      expansion, rarity
    FROM cards
    WHERE name = ?
    SQL
    info = @db.execute( card_retrieve_text, name )
    (card.name, card.cost, card.type, card.supertype, card.subtypes,
     card.power, card.toughness, card.text, card.expansion, card.rarity) = info.first

    puts info.inspect
    card.subtypes = eval card.subtypes # Wow awful
    card

  end

  def db_ready?
    table_exists = @db.execute <<-SQL
      SELECT name
      FROM sqlite_master
      WHERE type='table' AND name='cards';
    SQL
    return table_exists.any?
  end

  def connect_to_db
    @db = SQLite3::Database.new @path
    self.set_up_database unless db_ready?
  end

  def set_up_database
    rows = @db.execute <<-SQL
      create table cards (
            name varchar(150) PRIMARY KEY,
            cost varchar(10),
            type varchar(40),
            supertype varchar(20),
            subtypes varchar(40),
            power int,
            toughness int,
            text varchar(400),
            expansion varchar(5),
            rarity varchar(5)
      );
    SQL
  end

  def add_many_cards(cards)
    @db.execute( 'BEGIN' )
    cards.each do |card|
      puts card.name
      self.add_card(card)
    end
    @db.execute( 'COMMIT' )

  end

  def add_card (card)
    # Card Insert Text
    card_insert_text = <<-SQL
      INSERT OR REPLACE INTO cards
      ( name, cost, type, supertype, subtypes,
      power, toughness, text, expansion, rarity )
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    SQL
    @db.execute(card_insert_text, card.name.to_s, card.cost.to_s,
                card.type.to_s, card.supertype.to_s, card.subtypes.to_s, card.power,
                card.toughness, card.text.to_s, card.expansion.to_s, card.rarity.to_s
               )
  end

end
