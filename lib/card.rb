class Card
  attr_accessor :name
  attr_accessor :cost
  attr_accessor :type
  attr_accessor :text
  attr_accessor :power
  attr_accessor :toughness
  attr_accessor :expansion
  attr_accessor :rarity
  attr_accessor :supertype
  attr_accessor :subtypes

  @@card_type_regex = /
    ((?<super> \w+) \s+)? # An optional supertype
    (?<type> \w+) # Mandatory main type
    \s* (--)? \s* # Separator before subtypes
    (?<subtypes> .*)?/x #Optional subtypes

  @@cost_regex = /^[0-9WUGBRX]+$/

  @@colors_of_magic = ['W', 'U', 'B', 'R', 'G']

  def initialize (text = nil)
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

    @name = lines.shift

    # Some cards are "special". Easiest way to detect is if the cost looks fishy.
    cost_or_type = lines.shift
    if @@cost_regex.match cost_or_type then
      @cost = cost_or_type
    else
      lines.unshift cost_or_type # Put it back
    end

    typedata = @@card_type_regex.match lines.shift
    @type = typedata[:type]
    @supertype = typedata[:super]
    @subtypes = typedata[:subtypes].split

    (@expansion, @rarity) = lines.pop.split '-'

    if (@type == 'Creature') then
      (@power, @toughness) = lines.shift.split '/'
    end
    @text = lines.join("\n")

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
    text = "#{@name}\n"
    text << "#{@cost}\n" unless @cost.empty?
    text << "#{@supertype} " if @supertype
    text << @type
    text << " -- #{@subtypes.join(' ')}" if not @subtypes.nil? and @subtypes.any?
    text << "\n"
    text << "#{@power}/#{@toughness}\n" unless @power.nil? and @toughness.nil?
    text << "#{@text}\n" unless @text.empty?
    text << "#{@expansion}-#{@rarity}\n"
  end

  def colors
    @cost.split('') & @@colors_of_magic
  end

  def cmc
    / X*         # Xs don't count towards converted mana cost
      ([0-9]*)   # Digits
      ([WUBRG]*) # Color symbols
    /x .match @cost
    $1.to_i + $2.length #Digits, read as a number, plus number of colored mana symbols
  end

end
