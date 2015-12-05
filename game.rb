require_relative "board"

class SnailsPaceRace
  attr_reader :board

  def initialize(board=Board.new)
    @board = board
  end

  def clear_terminal
    puts "\e[H\e[2J"
  end

  def play_turn
    clear_terminal
    board.render
    puts "\nPress enter to roll the dice!"
    gets
    roll1, roll2 = roll_dice
    puts "You rolled #{Board.snail_colors[roll1].to_s} and #{Board.snail_colors[roll2].to_s}.\n\n"
    print "Press enter to move the snails!"
    gets
    board.move_snails(roll1, roll2)
  end

  def roll_dice
    [roll_die, roll_die]
  end

  def roll_die
    rand(6)
  end

  def play
    play_turn until board.won?
    clear_terminal
    board.render
    board.declare_winner
  end
end


if $PROGRAM_NAME == __FILE__
  game = SnailsPaceRace.new
  game.play
end
