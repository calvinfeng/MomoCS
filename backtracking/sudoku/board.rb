require_relative 'tile'

class Board
    def self.empty_grid
        Array.new(9) do
            Array.new(9) { Tile.new(0) }
        end
    end

    def self.from_file(filename)
        rows = File.readlines(filename).map(&:chomp)
        tiles = rows.map do |row|
            nums = row.split("").map { |char| Integer(char) }
            nums.map { |num| Tile.new(num) }
        end
        self.new(tiles)
    end

    def initialize(grid=Board.empty_grid)
        @grid = grid
    end

    def [](pos)
        row, col = pos
        grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        tile = grid[row][col]
        tile.value = value
    end

    def columns
        rows.transpose
    end

    def self.from_file(filename)
        rows = File.readlines(filename).map(&:chomp)
        tiles = rows.map do |row|
            nums = row.split("").map { |char| Integer(char) }
            nums.map { |num| Tile.new(num) }
        end
        self.new(tiles)
    end

    def rows
        @grid
    end

    def size
        @grid.size
    end

    def solved?
        rows.all? { |row| solved_set?(row) } &&
        columns.all? { |col| solved_set?(col) } &&
        squares.all? { |square| solved_set?(square) }
    end

    def square(idx)
        tiles = []
        x = (idx / 3) * 3
        y = (idx % 3) * 3

        (x...x + 3).each do |i|
            (y...y + 3).each do |j|
                tiles << self[[i, j]]
            end
        end
    end

    def dup
        duped_grid = grid.map do |row|
            row.map { |tile| Tile.new(tile.value) }
        end

        Board.new(duped_grid)
    end
end
