require_relative "tile"
require 'byebug'

class Board

  def initialize(grid = Array.new(9){[]}, bombs = 50)
    @grid = grid
    @bombs = bombs
    populate
    place_count
  end

  def populate
    tiles = []
    @bombs.times { tiles << Tile.new(true) }

    (81 - @bombs).times { tiles << Tile.new(false) }

    tiles.shuffle!

    @grid.each do |row|
      row.concat(tiles.shift(9))
    end
  end

  def place_count
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        bomb_number = count(row_idx, col_idx, @grid[row_idx][col_idx])
        col.neighbor_bombs = bomb_number
      end
    end
  end

  def count(row_idx, col_idx, tile)

    return 0 if tile.bomb
    adjacent_tiles = []
    bomb_count = 0

    min_row = row_idx > 0 ? row_idx - 1 : 0
    max_row = row_idx < 8 ? row_idx + 1 : 8
    min_col = col_idx > 0 ? col_idx - 1 : 0
    max_col = col_idx < 8 ? col_idx + 1 : 8

    a = @grid[min_row][min_col..max_col]
    b = @grid[row_idx][min_col..max_col]
    c = @grid[max_row][min_col..max_col]

    adjacent_tiles = a + b + c
    adjacent_tiles.uniq!

    adjacent_tiles.flatten.each do |i|
      next if i.nil?
      bomb_count += 1 if i.bomb
    end

    bomb_count
  end

  def handle_response(pos)
    if @grid[pos[0]][pos[1]].bomb
      game_over
    else
      explore([pos])
    end

  end

  def explore(pos)
    #debugger
    pos.each do |posn|
      @grid[posn[0]][posn[1]].revealed = true
      if @grid[posn[0]][posn[1]].neighbor_bombs == 0
        explore(neighbors(posn))
      end
    end
    render
  end

  def neighbors(pos)
    row = pos[0]
    col = pos[1]

    results = []

    (row-1..row+1).each do |i|
      (col-1..col+1).each do |j|
        results << [i, j] unless i<0 || i>8 || j<0 || j>8 || i == row || j == row
      end
    end

    results
  end

  def game_over
    @grid.each {|r| r.each {|el| el.revealed = true}}
    render
    put "GAME OVER"
  end

  def render
    #debugger
    @grid.each do |row|
      display_row = ""
      row.each do |col|
        display_row << " #{col.display} "
      end
      puts display_row
    end
  end


end

if __FILE__ == $PROGRAM_NAME
  b = Board.new()
  b.render
  b.explore([2,3])
end
