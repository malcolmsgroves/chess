require_relative 'moves'

class Piece
  include PieceMethods
  attr_accessor :color, :pos

  def initialize(color, pos)
    @color = color
    @pos = pos
  end
end

class Rook < Piece
  attr_accessor :type

  def initialize(color, pos)
    super(color, pos)
    @type = :rook
  end

  def get_moves(board)
    slide(board, :straight, :slide)
  end
end

class Bishop < Piece
  attr_accessor :type

  def initialize(color, pos)
    super(color, pos)
    @type = :bishop
  end

  def get_moves(board)
    slide(board, :diagonal, :slide)
  end
end
