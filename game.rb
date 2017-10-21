require_relative 'pieces/pieces'

class Chess

  def initialize
    @board = Array.new(8) {Array.new(8)}
    @board[4][4] = Rook.new(:black, [4, 4])
  end


end
