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
    @board[[4, 4]] = Rook.new(:white, [4, 4])
  end

  def moves_at(coords)
    square = @board[coords]
    square.nil? ? nil : square.get_moves(@board)
  end


end
