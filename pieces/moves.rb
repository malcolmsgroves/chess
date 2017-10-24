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

  knight_moves = []

  [1, -1].each do |dx|
    [1, -1].each do |dy|
      knight_moves += [[1 * dx, 2 * dy], [2 * dx, 1 * dy]]
    end
  end

  KNIGHT = knight_moves

  DIRECTIONS = {diagonal: DIAGONAL, straight: STRAIGHT, knight: KNIGHT}

  def to_string

    return " " + PIECE[@color][@type] + " "
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
        curr_square = board[coords]
      end

      #kill clause
      if !curr_square.nil? && curr_square.color != @color
        moves.push(coords)
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
