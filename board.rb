require_relative "tile"
require 'byebug'

class Board

  def initialize(grid = Array.new(9){[]})
    @grid = grid
    populate
    place_count
  end

  def populate
    tiles = []
    bombs = 1
    bombs.times { tiles << Tile.new(true) }

    (81 - bombs).times { tiles << Tile.new(false) }

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

  def render
    debugger
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
  b = Board.new
  b.render
end
