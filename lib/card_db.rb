class CardDB
  @path = nil
  @db = nil

  def initialize (path = 'data/card.db')
    @path = path
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
            type varchar(20),
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
  @db.execute( card_insert_text,
      card.name.to_s, card.cost.to_s, card.types.to_s, nil,
      nil, card.power, card.toughness, card.text,
      card.expansion, card.rarity
   )
  end

end
