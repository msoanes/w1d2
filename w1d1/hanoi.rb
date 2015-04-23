class Hanoi
  attr_reader :towers

  @@solution = [[], [], [2, 1, 0]]

  def initialize
    @towers = [ [2, 1, 0], [], [] ]
  end

  def render
    print "\t#{towers[0]}\n\t#{towers[1]}\n\t#{towers[2]}\n"
  end

  def move(from, to)
    # from is not empty
    # validate last element of 'to' is larger than moving element
    if !@towers[from].empty? &&
        (@towers[to].length == 0 ||
        @towers[to].last > @towers[from].last)
      @towers[to] << @towers[from].pop
    else
      puts "Invalid move"
    end
  end

  def start
    loop do
      render
      puts "pick from"
      from = gets.chomp.to_i
      puts "pick to"
      to = gets.chomp.to_i
      move(from, to)
      if @towers == @@solution
        render
        puts "Congrats! You win!"
        break
      end
    end
  end
end

new_game = Hanoi.new
new_game.start

# new_game.render
# new_game.move(0,2)
# new_game.render
# new_game.move(0,2)
# new_game.render
