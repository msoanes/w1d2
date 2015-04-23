class Board
  attr_reader :grid, :winner

  def initialize
    @grid = Array.new(3) { Array.new(3) }
    @winner = nil
  end

  def won?
    grid.each do |column|
      if not_nil_and_equal?(column[0], column[1], column[2])
        @winner = column[0]
        return true
      end
    end

    3.times do |i|
      if not_nil_and_equal?(grid[0][i], grid[1][i], grid[2][i])
        @winner = grid[0][i]
        return true
      end
    end

    if not_nil_and_equal?(grid[0][0], grid[1][1], grid[2][2])
      @winner = grid[0][0]
      return true
    end

    if not_nil_and_equal?(grid[0][2], grid[1][1], grid[2][0])
      @winner = grid[0][2]
      return true
    end

    false
  end

  def not_nil_and_equal?(*values)
    equal = values.all? { |value| value == values.first }
    equal && !values.first.nil?
  end


  def draw?
    flat = grid.flatten
    flat.all? { |position| !position.nil? }
  end

  def empty?(position)
    x, y = position
    grid[y][x].nil?
  end

  def place_mark(pos, mark)
    x, y = pos
    grid[y][x] = mark
  end

  def render
    grid.each do |column|
      p column
      puts
    end
  end
end


class Game
  attr_reader :player1, :player2, :board

  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @player_symbol = :x
  end

  def play
    while !(board.won? || board.draw?) do
      position = fetch_move
      board.place_mark(position, @player_symbol)
    end
    board.render
    winner = "Nobody"
    winner = "Player 1" if board.winner == :x
    winner = "Player 2" if board.winner == :o
    puts "Congratulations #{winner}"
  end

  def switch_player
    if @player_symbol == :x
      current_player = player1
      @player_symbol = :o
    else
      current_player = player2
      @player_symbol = :x
    end
    current_player
  end

  def fetch_move
    current_player = switch_player
    loop do
      position = current_player.get_move(board)
      if board.empty?(position)
        return position
      else
        current_player.invalid_move(position)
      end
    end
  end
end

class HumanPlayer

  def invalid_move(position)
    puts "Position taken"
  end

  def get_move(board)
    error_message = "Position not valid"
    board.render
    x_input = prompt("Choose a x position", error_message) do |input|
      input < 3
    end
    y_input = 2 - prompt("Choose a y position", error_messege) do |input|
      input < 3
     end
    [x_input, y_input]
  end

  private

    def prompt(message, err_message, &prc)
      loop do
        puts message
        input = Integer(gets)
        return input if prc.call(input)
        puts err_message
      end
    end
end

class ComputerPlayer
  def get_move(board)
    available_moves = Array.new
    board.grid.each_with_index do |col, x|
      col.each_index do |y|
        if col[y].nil?
          available_moves << [y,x]
        end
      end
    end
    available_moves.sample
  end

  def invalid_move(position)
    get_move
  end

end

game = Game.new(ComputerPlayer.new, ComputerPlayer.new)
game.play
