require "io/console"

module Cursorable
  KEYHASH = {
    "\e[A"  => :up,
    "\e[B"  => :down,
    "\e[C"  => :right,
    "\e[D"  => :left,
    "\r"    => :return,
    "\e"    => :escape,
    "?"     => :question,
    " "     => :spacebar,
  }

  def me
    puts "me"
  end

  def get_input
    key = KEYHASH[read_char]
    handle_key(key)
  end


  def handle_key(key)
    case key
    when :up, :down, :left, :right
      puts "make a move"
    when :question
      puts "directions"
    when :spacebar, :return
      exit 0
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
