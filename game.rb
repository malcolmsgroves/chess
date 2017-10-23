require_relative 'pieces/pieces'

class Chess

  def initialize
    @turn = :white
    @board = Hash.new
    @kings = {black: [7, 3], white: [0, 3]}
    @status = :in_progress

    (0...8).each do |x|
      (0...8).each do |y|
        @board[[x, y]] = nil
      end
    end
    @board[@kings[:white]] = King.new(:white, @kings[:white])
    @board[@kings[:black]] = King.new(:black, @kings[:black])
    @board[[4, 3]] = Queen.new(:black, [4, 3])
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

=begin
Need to have a method for checking for check.
First: remove all possible moves that result in a check
Second: Tell if a player is IN check
Third: Identify checkmate
=end

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

  # check if a specified color is in check
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
