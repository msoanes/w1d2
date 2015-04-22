class RPNCalculator
  attr_accessor :stack

  def initialize
    @stack = []
  end

  def push(character)
    if character =~ /^[0-9]*$/
      stack.push(Integer(character))
    else
      case character
      when '+'
        plus
      when '*'
        times
      when '-'
        minus
      when '/'
        divide
      end
    end
  end

  def minus
    first = stack.pop
    stack << stack.pop - first
  end

  def plus
    stack << stack.pop + stack.pop
  end

  def times
    stack << stack.pop * stack.pop
  end

  def divide
    first = stack.pop
    stack << stack.pop/first
  end

  def read_from_stdinput
    print '> '
    raw_input = gets.chomp
    input_array = push_array(raw_input)
    puts stack.last
    input_array.last
  end

  def read_from_file
    file_str = File.readlines(ARGV[0]).join(' ')
    push_array(file_str)
    puts stack.last
  end

  def loop_stdinput
    last_char = nil
    while last_char != 'q'
      last_char = read_from_stdinput
    end
  end

  def run
    if ARGV[0]
      read_from_file
    else
      loop_stdinput
    end
  end

  def push_array(input_str)
    input_arr = input_str.split
    input_arr.each do |char|
      push(char)
    end
    input_arr
  end

end

rpn = RPNCalculator.new
rpn.run
