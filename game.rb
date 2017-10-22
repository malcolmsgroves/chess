require_relative 'pieces/pieces'

class Chess

  def initialize
    @turn = :white
    @board = Hash.new
    (0...8).each do |x|
      (0...8).each do |y|
        @board[[x, y]] = nil
      end
    end
    @board[[0, 0]] = Rook.new(:white, [0, 0])
    @board[[0, 1]] = Bishop.new(:black, [0, 1])
  end

  def moves_at(coords)
    square = @board[coords]
    square.nil? ? nil : square.get_moves(@board)
  end

  def toggle_turn
    @turn = @turn == :white ? :black : :white
  end

  def move_piece(from, to)
    @board[to] = @board[from]
    @board[to].pos = to
    @board[from] = nil
    toggle_turn
  end

end
