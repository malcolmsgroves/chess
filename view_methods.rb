

module ViewMethods

  def move_cursor(move)
    if on_board(move)
      @selected = [@selected[0] + move[0], @selected[1] + move[1]]
    end
  end

  def highlight
    if !@board[@selected].nil? && @board[@selected].color == @turn
      @highlighted = moves_at(@selected)
    end
  end

  def on_board(coords)
    @selected[0] + coords[0] < 8 &&
    @selected[1] + coords[1] < 8 &&
    @selected[0] + coords[0] >= 0 &&
    @selected[1] + coords[1] >= 0
  end

  def render
    system "clear"

    (0...8).each do |x|
      (0...8).each do |y|
        square = @board[[x, y]]

        #TODO refactor this crap
        bg = (x + y) % 2 == 0 ? :white : :grey
        bg = :cyan if @selected == [x, y]
        bg = :green if @highlighted.include? [x, y]

        str = get_string(square)
        print str.colorize(:background => bg)
      end
      puts
    end
    
  end

  def get_string(square)
    square.nil? ? "   " : square.to_string
  end



end
