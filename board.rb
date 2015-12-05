class Board
  attr_reader :grid

  def self.snail_colors
    {
      0 => :orange,
      1 => :blue,
      2 => :pink,
      3 => :red,
      4 => :yellow,
      5 => :purple
    }
  end

  def initialize
    @grid = Array.new(6,:-){Array.new(10,:-)}
    @grid.length.times {|idx| self[[idx,0]] = "@Y"}
  end

  def render
    puts "SNAIL'S PACE RACE!\n\n"
    grid.each_with_index do |row,idx|
      print row.join
      print " " + Board.snail_colors[idx].to_s.capitalize + "\n"
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
      winners << Board.snail_colors[idx] if row.last == "@Y"
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
      snail_pos = grid[roll].index("@Y")
      self[[roll, snail_pos + 1]] = "@Y"
      self[[roll, snail_pos]] = :-
    end
  end

  def []
  end

  def won?
    grid.any? {|row| row.last == "@Y"}
  end

end
