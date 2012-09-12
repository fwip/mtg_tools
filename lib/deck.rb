class Deck
  attr_accessor :author
  attr_accessor :date
  attr_accessor :name

  # Hashes: (key, value) -> (name, count)
  @cards = nil
  @sideboard = nil

  def load_mtgo_format (text)
    @cards = {}
    @sideboard = {}
    in_main = true
    text.each_line do |line|
      line.chomp!

      if (line[0] == '#') then
        # Handle special fields
        line[0] = ''
        (key, *valuelist) = line.split
        value = valuelist.join ' '
        case key.downcase
        when 'author'
          @author = value
        when 'date'
          @date = Date.parse(value)
        when 'name'
          @name = value
        end

      else

        if (line.empty?) then
          in_main = false
        else
          (count, *nameparts) = line.split
          name = nameparts.join ' '
          if (in_main) then
            @cards[name] = count
          else
            @sideboard[name] = count
          end
        end
      end
    end
  end


  def to_s (format='mtgo')
    # For now, only supports mtgo format
    list = ''
    list << "#Author #{@author}\n" if @author
    list << "#Name #{@name}\n"     if @name
    list << "#Date #{@date}\n"     if @date
    @cards.each do |k, v|
      list << "#{v} #{k}\n"
    end
    list << "\n"
    @sideboard.each do |k, v|
      list << "#{v} #{k}\n"
    end

    return list
  end
end
