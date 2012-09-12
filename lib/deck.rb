class Deck
  @author = nil
  @date = nil

  # Hashes: (key, value) -> (name, count)
  @cards = nil
  @sideboard = nil

  def load_mtgo_format (text)
    @cards = {}
    @sideboard = {}
    in_main = true
    text.each_line do |line|
      line.chomp!
      if (line.empty?) then
        in_main = false
      else
        (count, *nameparts) = line.split( /\s+/)
        name = nameparts.join ' '
        if (in_main) then
          @cards[name] = count
        else
          @sideboard[name] = count
        end
      end
    end
  end


  def to_s (format='mtgo')
    # For now, only supports mtgo format
    list = ''
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
