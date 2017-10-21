require "io/console"

module Cursorable
  KEYHASH = {
    "\e[A"  => :left,
    "\e[B"  => :right,
    "\e[C"  => :up,
    "\e[D"  => :down,
    "\r"    => :return,
    "\e"    => :escape,
    "?"     => :question,
    " "     => :spacebar,
  }

  MOVES = {
    up:     [0, 1],
    down:   [0, -1],
    left:   [-1, 0],
    right:  [1, 0]
  }


  def get_input
    key = KEYHASH[read_char]
    handle_key(key)
  end


  def handle_key(key)
    case key
    when :up, :down, :left, :right
      move_cursor(MOVES[key])
    when :question
      puts "directions"
    when :spacebar
      exit 0
    when :return
      puts "highlight possible moves"
    else
      puts key
    end
  end


  def read_char
    STDIN.echo = false     #set to false to avoid printing to console
    STDIN.raw!            #give escape sequences and the whole mess

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    # reset terminal settings
    STDIN.echo = true
    STDIN.cooked!

    return input
  end
end
