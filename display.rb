require "colorize"
require_relative "pieces/moves"
require_relative "game"

class Display < Chess

  def initialize
    super
    @highlighted = []
    @selected = [0, 0]
  end

  def render
    system "clear"

    @board.each_with_index do |row, x|
      row.each_with_index do |square, y|

        bg = (x + y) % 2 == 0 ? :white : :grey
        bg = :blue if @selected == [x, y]
        bg = :yellow if @highlighted.include? [x, y]

        str = get_string(square)
        print str.colorize(:background => bg)
      end
      puts
    end
  end

  def get_string(square)
    square.nil? ? "   " : square.to_string
  end

end

game = Display.new
game.render
