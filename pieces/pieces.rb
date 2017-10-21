require_relative 'moves'

class Rook

  attr_accessor :type, :color, :pos
  include PieceMethods


  def initialize(color, pos)
    @color = color
    @pos = pos
    @type = :rook
  end

  def get_moves(board)
    straight_slide
  end


end
