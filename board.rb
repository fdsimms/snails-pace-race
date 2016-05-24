require 'rainbow'

class Board
  attr_reader :grid

  def self.snail_colors
    {
      0 => :red,
      1 => :green,
      2 => :yellow,
      3 => :blue,
      4 => :magenta,
      5 => :cyan
    }
  end

  def initialize
    @grid = Array.new(6, :-){Array.new(10, :-)}
    @grid.length.times do |idx|
      color = Board.snail_colors[idx]
      self[[idx, 0]] = Rainbow("@Y").send(color)
    end
  end

  def render
    puts "SNAIL'S PACE RACE!\n\n"
    grid.each_with_index do |row, idx|
      color = Board.snail_colors[idx]
      print row.join
      print Rainbow(" " + color.to_s.capitalize).send(color) + "\n"
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, marker)
    x, y = pos
    grid[x][y] = marker
  end

  def winner
    winners = []
    grid.each_with_index do |row, idx|
      winners << Board.snail_colors[idx] if row.last != :-
    end
    winners
  end

  def declare_winner
    one_snail_winner = "The #{winner.join} snail won!"
    two_snail_winner = "The #{winner.join(" and ")} snails won!"
    puts winner.length == 1 ? one_snail_winner : two_snail_winner
  end

  def move_snails(*rolls)
    rolls.each do |roll|
      snail_pos = grid[roll].index { |el| el != :-}
      color = Board.snail_colors[roll]
      self[[roll, snail_pos + 1]] = Rainbow("@Y").send(color)
      self[[roll, snail_pos]] = :-
    end
  end

  def won?
    grid.any? {|row| row.last != :-}
  end

end
