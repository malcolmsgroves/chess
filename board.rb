require_relative 'pieces/pieces'

class Board

  def initialize
    @turn = :white
    @board = Hash.new
    @kings = {black: [7, 3], white: [0, 3]}
    @status = :in_progress

    instantiate_board
  end

  def instantiate_board
    (0...8).each do |r|
      (0...8).each do |c|
        place_piece(r, c)
      end
    end
  end

  def place_piece(r, c)
    if r == 1
      @board[[r, c]] = Pawn.new(:white, [r, c])
    elsif r == 6
      @board[[r, c]] = Pawn.new(:black, [r, c])
    elsif r == 0
      if c == 0 || c == 7
        @board[[r, c]] = Rook.new(:white, [r, c])
      elsif c == 1 || c == 6
        @board[[r, c]] = Knight.new(:white, [r, c])
      elsif c == 2 || c == 5
        @board[[r, c]] = Bishop.new(:white, [r, c])
      elsif c == 3
        @board[[r, c]] = King.new(:white, [r, c])
      elsif c == 4
        @board[[r, c]] = Queen.new(:white, [r, c])
      end
    elsif r == 7
      if c == 0 || c == 7
        @board[[r, c]] = Rook.new(:black, [r, c])
      elsif c == 1 || c == 6
        @board[[r, c]] = Knight.new(:black, [r, c])
      elsif c == 2 || c == 5
        @board[[r, c]] = Bishop.new(:black, [r, c])
      elsif c == 3
        @board[[r, c]] = King.new(:black, [r, c])
      elsif c == 4
        @board[[r, c]] = Queen.new(:black, [r, c])
      end
    else
      @board[[r, c]] = nil
    end


  end

  def moves_at(coords)
    square = @board[coords]
    return nil if square.nil?

    moves = square.get_moves(@board)
    moves = moves.delete_if {|move| to_check(coords, move)}
    moves.empty? ? nil : moves
  end

  def toggle_turn
    @turn = (@turn == :white) ? :black : :white
  end

  def move_piece(from, to)
    @board[to] = @board[from]
    @board[to].pos = to
    @board[from] = nil
    if @board[to].type == :king
      @kings[@turn] = to
    end
  end

  def to_check(coords, move)
    from = @board[coords].dup
    to = @board[move].dup
    king_start = @kings[@turn].dup

    move_piece(coords, move)
    in_check = false
    in_check = true if check?(@turn)

    # reset everything
    @board[coords] = from
    @board[move] = to
    @kings[@turn] = king_start

    in_check
  end

  def update_status
    @status = (@turn == :black ? :black_check : :white_check) if check?(@turn)
    no_possible_moves = true
    each do |piece|
      if !piece.nil? && piece.color == @turn
        no_possible_moves = false if !moves_at(piece.pos).nil?
      end
      break if !no_possible_moves
    end
    @status = (@turn == :black ? :black_checkmate : :white_checkmate) if no_possible_moves

    case @status
    when :black_check
      return "Black is in check"
    when :white_check
      return "White is in check"
    when :white_checkmate
      return "Checkmate - black wins!"
    when :black_checkmate
      return "Checkmate - white wins!"
    else
      return nil
    end
  end

  def check?(color)
    each do |piece|
      if !piece.nil? && piece.color != color
        return true if piece.get_moves(@board).include? @kings[color]
      end
    end
    false
  end

  def each(&block)
    (0...8).each do |row|
      (0...8).each do |col|
        block.call(@board[[row, col]])
      end
    end
  end
end
