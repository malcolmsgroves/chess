require_relative 'pieces/pieces'

class Chess

  def initialize
    @turn = :white
    @board = Hash.new
    @kings = {black: [7, 3], white: [0, 3]}
    @checked = nil

    (0...8).each do |x|
      (0...8).each do |y|
        @board[[x, y]] = nil
      end
    end
    @board[[0, 0]] = Rook.new(:white, [0, 0])
    @board[[6, 0]] = Pawn.new(:black, [6, 0])
  end

  def moves_at(coords)
    square = @board[coords]
    square.nil? ? nil : square.get_moves(@board)
  end

  def toggle_turn
    @turn = (@turn == :white) ? :black : :white
  end

  def move_piece(from, to)
    @board[to] = @board[from]
    @board[to].pos = to
    @board[from] = nil
    if @board[to].type == :king
      @kings[turn] = to
    end
    toggle_turn

  end

=begin
Need to have a method for checking for check.
First: remove all possible moves that result in a check
Second: Tell if a player is IN check
Third: Identify checkmate
=end

  def check(coords)
    king_position = @turn == :black ? @black_king : @white_king
    (0...8).each do |x|
      (0...8).each do |y|
        if !@board[[x, y]].nil? && @board[[x, y]].color != @turn
          return false if moves_at([x, y]).include? king_position
        end
      end
    end
    true
  end

  def each(&prc)
    @board.each do |row|
      row.each do |square|
        prc.call(square)
      end
    end
  end

  def get_pieces(color)
    pieces = []
    each do |piece|
      pieces << piece if piece.color = color
    end
    pieces
  end

end
