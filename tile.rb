class Tile

  attr_reader :bomb, :flagged
  attr_accessor :revealed, :neighbor_bombs

  def initialize(bomb, revealed = false, flagged = false)
    @bomb = bomb
    @revealed = revealed
    @flagged = flagged
    @neighbor_bombs = 0
  end



  def flagger
    @flagged = !flagged
  end

  def display
    if @revealed && @neighbor_bombs == 0
      "_"
    elsif @revealed && @neighbor_bombs > 0
      @neighbor_bombs.to_s
    elsif flagged == true
      "F"
    else
      "*"
    end
  end

end
