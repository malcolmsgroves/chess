require "colorize"
require_relative "pieces/moves"
require_relative "game"
require_relative "cursorable"

class Display < Chess

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

  def move_cursor(move)
    if on_board(move)
      @curr_pos = [@curr_pos[0] + move[0], @curr_pos[1] + move[1]]
    end
  end

  def select_square
    # new selected square
    if !@board[@curr_pos].nil? &&
        @board[@curr_pos].color == @turn &&
        @selected.nil?
      @highlighted = moves_at(@curr_pos) if !moves_at(@curr_pos).nil?
      @selected = @curr_pos

    #toggle selected square
    elsif @selected == @curr_pos
      @selected = nil
      @highlighted.clear

    elsif @highlighted.include? @curr_pos
      move_piece(@selected, @curr_pos)
      toggle_turn
      @selected = nil
      @highlighted.clear
    else
      @selected = nil
      @highlighted.clear
    end
  end

  def on_board(coords)
    @curr_pos[0] + coords[0] < 8 &&
    @curr_pos[1] + coords[1] < 8 &&
    @curr_pos[0] + coords[0] >= 0 &&
    @curr_pos[1] + coords[1] >= 0
  end

  def render
    system "clear"

    (0...8).each do |x|
      (0...8).each do |y|
        square = @board[[x, y]]

        #TODO refactor this crap
        bg = (x + y) % 2 == 0 ? :white : :grey
        bg = :green if @highlighted.include? [x, y]
        bg = :cyan if @curr_pos == [x, y]

        str = get_string(square)
        print str.colorize(:background => bg)
      end
      puts
    end
    puts @message
  end

  def get_string(square)
    square.nil? ? "   " : square.to_string
  end


end

game = Display.new
game.play
