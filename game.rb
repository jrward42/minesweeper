require_relative 'board.rb'

class Minesweeper

  def initialize(player)
    @player = player
    @board = Board.new
  end

  def play
    until over?
      take_turn
    end
  end

  def take_turn
    pos = nil
    until valid_pos(pos)
      pos = get_pos
    end
    handle_response(pos)
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
    pos.is_a?(Array)&& pos.all?(|i| i>=0 && i<= 8)
  end

  def handle_response(pos)
    @board.handle_response(pos)
  end

end
