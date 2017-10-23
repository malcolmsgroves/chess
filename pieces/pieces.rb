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

class Queen < Piece
  attr_accessor :type

  def initialize(color, pos)
    super(color, pos)
    @type = :queen
  end

  def get_moves(board)
    slide(board, :diagonal, :slide) + slide(board, :straight, :slide)
  end
end

class King < Piece
  attr_accessor :type

  def initialize(color, pos)
    super(color, pos)
    @type = :king
  end

  def get_moves(board)
    slide(board, :diagonal, :step) + slide(board, :straight, :step)
  end
end

class Knight < Piece
  attr_accessor :type

  def initialize(color, pos)
    super(color, pos)
    @type = :knight
  end

  def get_moves(board)
    slide(board, :knight, :step)
  end
end

class Pawn < Piece
  attr_accessor :type

  def initialize(color, pos)
    super(color, pos)
    @type = :pawn
  end

  def get_moves(board)
    moves = []

    # black starts at bottom, white starts at top
    org_row = (@color == :black) ? 6 : 1
    dir = (@color == :black) ? -1 : 1

    forward = next_pos(@pos, [dir, 0])
    double_step = next_pos(@pos, [2 * dir, 0])
    kill = [next_pos(@pos, [dir, 1]), next_pos(@pos, [dir, -1])]

    moves.push(forward) if board[forward].nil?
    moves.push(double_step) if board[double_step].nil? && @pos[0] == org_row
    kill.each do |move|
      moves.push(move) if !board[move].nil? && board[move].color != @color
    end
    moves
  end
end
