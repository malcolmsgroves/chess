# Chess
A two-player chess game in the terminal written in ruby. Implements the standard rules of chess and prevents players from making illegal moves such as moving into check. 

## Run
Download the files from GitHub and cd into the repository. The main method is in ```display.rb```, so type ```ruby display.rb``` in the terminal to run the program. 

## Commands
When the chess program is running in the terminal, you can execute the following commands with the keyboard
  * Move the chess square pointer using the arrow keys
  * Select the chess piece at the pointer with the ```return``` key. All possible moves will be highlighted. You can then select a possible move from amongst the highlighted squares. If you select a square that is not highlighted, the highlighted squares will be cleared.
  * Exit the game by pressing ```spacebar```.
  
## Implementation
This program makes use of modular design, OOP, and DRY logic.

### Piece Classes
All of the piece classes inherit from a super Piece class which includes a PieceMethods module that describes general methods for piece movement and unicode characters. This enables bone-DRY piece classes such as the following Rook class
```ruby
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
```
All pieces except for the pawns use a general #slide method to generate moves
```ruby
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

      # kill clause
      if !curr_square.nil? && curr_square.color != @color
        moves.push(coords)
      end
    end
    moves
  end
```

### Board Class
The Board class contains the nuts and bolts for the chess game. It holds the chessboard, facilitates moves, and enforces check and checkmate. The following code snippet is the base #check? method which ascertains whether a certain color is in check by checking all the possible moves of the opposing team and returning true if the opposing team can kill the king.
```ruby
def check?(color)
    each do |piece|
      if !piece.nil? && piece.color != color
        return true if piece.get_moves(@board).include? @kings[color]
      end
    end
    false
  end
```

### Display Class
To maintain DRY design and to improve reusability, the Display class inherits the Board class and includes a Cursorable module that contains methods receiving and handling user input. The display class has two primary tasks: changing the @board instance variable upon user input and rendering the @board in the terminal. The methods available to the user via the Cursorable module are as follows
```ruby
def handle_key(key)
    case key
    when :up, :down, :left, :right
      move_cursor(MOVES[key])
    when :question
      puts "directions"
    when :spacebar
      exit 0
    when :return
      select_square
    else
      puts key
    end
  end
```

## Future
A general refactoring of the code to include more of ruby's *syntactic sugar* would be worthwhile - this is more of a pythonic implementation of ruby. In addition, specialized chess moves such as *castling* should be included in the moves available to the players. Finally, the game should be made serializable since chess games can be long!
