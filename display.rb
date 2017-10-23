require "colorize"
require_relative "pieces/moves"
require_relative "game"
require_relative "cursorable"
require_relative "view_methods"

class Display < Chess

  include ViewMethods
  include Cursorable


  def initialize
    super
    @highlighted = []
    @selected = nil
    @curr_pos = [0, 0]
    @message = nil
  end

  def play
    while @game_status != :black_checkmate && @game_status != :white_checkmate
      curr_turn = @turn
      while curr_turn == @turn
        render
        get_input
      end
      @message = update_status
    end

    render

  end




end

game = Display.new
game.play

=begin
TODO Complete the game class by finishing all the pieces with move functionality
and adding methods for getting all possible moves. Also have to consider how
to address killing other pieces - should probably make the possible move method
in the board module so it can access the board.

Will have to let the Display class call the get possible move method and move
the pieces so that they will not move otherwise. Also need to highlight the
possible moves and add cntrl-c to the escape sequences.

=end
