class Card
  attr_accessor :name
  attr_accessor :cost
  attr_accessor :types
  attr_accessor :text
  attr_accessor :power
  attr_accessor :toughness
  attr_accessor :expansion
  attr_accessor :rarity


  # Sample card definition follows:
  #
  #Goblin Piledriver
 #1R
 #Creature -- Goblin Warrior
 #1/2
 #Protection from blue
 #Whenever Goblin Piledriver attacks, it gets +2/+0 until end of turn for each other attacking Goblin.
 #ONS-R
  def load_from_text (text)
    lines = text.each_line
    @name = lines[0]
    @cost = lines[1]
    @types = lines[2].split
    if (@types.includes? 'Creature')
      (@power, @toughness) = lines[3].split '/'
      @text = lines[4..-2]
    else
      @text = lines[3..-2]
    end
    (@expansion, @rarity) = lines[-1].split '-'

  end

end
