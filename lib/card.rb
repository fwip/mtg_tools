class Card
  attr_accessor :name
  attr_accessor :cost
  attr_accessor :types
  attr_accessor :text
  attr_accessor :power
  attr_accessor :toughness
  attr_accessor :expansion
  attr_accessor :rarity


  def initialize (text)
    if (text)
      self.load_from_text(text)
    end
  end

  # Sample card definition follows:
  #
  #Goblin Piledriver
  #1R
  #Creature -- Goblin Warrior
  #1/2
  #Protection from blue
  #Whenever Goblin Piledriver attacks, it gets +2/+0 until end of turn for each other attacking Goblin.
  #ONS-R
  def load_from_text(text)
    lines = text.each_line.map { |l| l.chomp }
    @name = lines[0]
    @cost = lines[1]
    @types = lines[2].split
    if (@types.include? 'Creature')
      (@power, @toughness) = lines[3].split '/'
      @text = lines[4..-2].join("\n")
    else
      @text = lines[3..-2].join("\n")
    end
    (@expansion, @rarity) = lines[-1].split '-'
  end

  # Format, where <> denotes mandatory, and [] denotes optional.
  # ----BEGIN FORMAT EXAMPLE----
  # <Name>
  # <Cost>
  # [Supertype] <Type> [-- [Optional] [Subtypes]]
  # [Power/Toughness]
  # [Text]
  # [Additional Text]
  # [More text]
  # <Expansion>-<Rarity>
  #
  # ----END FORMAT EXAMPLE----
  # Note: If there is no power/toughness, omit the line entirely
  # Same with text lines.
  def to_s
    text = [@name, @cost].join("\n") + "\n"
    text << @types.join(' ') + "\n"
    text << "#{@power}/#{@toughness}\n" unless @power.nil? and @toughness.nil?
    text << "#{@text}\n"
    text << "#{@expansion}-#{@rarity}\n"


  end

end
