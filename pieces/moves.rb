require 'colorize'

module PieceMethods



  WHITE = {
    king:    "\u2654",
    queen:   "\u2655",
    rook:    "\u2656",
    bishop:  "\u2657",
    knight:  "\u2658",
    pawn:    "\u2659",
  }
  BLACK = {
    king:    "\u265A",
    queen:   "\u265B",
    rook:    "\u265C",
    bishop:  "\u265D",
    knight:  "\u265E",
    pawn:    "\u265F",
  }

  PIECE = {:white => WHITE, :black => BLACK}

  DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  STRAIGHT = [[0, 1], [1, 0], [-1, 0], [0, -1]]

  DIRECTIONS = {diagonal: DIAGONAL, straight: STRAIGHT}

  def to_string

    return " " + PIECE[@color][@type] + " "
  end

  # make dir and style instance variables?
  def diagonal_slide(board)
    slide(board, :diagonal, :slide)
  end

  def straight_slide(board)
    slide(board, :straight, :slide)
  end

  def diagonal_step(board)
    slide(board, :diagonal, :step)
  end

  def straight_step(board)
    slide(board, :straight, :step)
  end

  def slide(board, dir, style)
    moves = Array.new
    max_step = (style == :step ? 1 : 10)    # step vs slide
    DIRECTIONS[dir].each do |delta|
      coords = next_pos(@pos, delta)
      curr_square = board[coords]
      num_step = 0

      while on_board(coords) && curr_square.nil? && num_step < max_step
        moves.push(coords)
        num_step += 1
        coords = next_pos(coords, delta)
      end
    end

    
    moves
  end

  def on_board(coords)
    coords[0] < 8 &&
    coords[1] < 8 &&
    coords[0] >= 0 &&
    coords[1] >= 0
  end

  def next_pos(coords, move)
    [coords[0] + move[0], coords[1] + move[1]]
  end

end
