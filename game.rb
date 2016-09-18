class Minesweeper

  def initialize(player)
    @player = player
  end

  def play
    until over?
      take_turn
    end
  end

  def take_turn
    pos = nil
    until valid_pos(pos)
      pos=get_pos
    end
  end

  def get_pos
    puts "Input a postion"
    pos=gets.chomp

    parse(pos)
  end

  def parse(pos)
    return ":(" unless pos.is_a?(string)
    pos.split(",").map{|el| Integer(el)}
  end

  def valid_pos?(pos)

  end

end
