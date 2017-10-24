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
All of the piece classes inherit from a super Piece class and include a PieceMethods module that describes general methods for piece movement and unicode characters. This enables bone-DRY piece classes such as the following Rook class
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
