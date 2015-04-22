class GuessingGame
  attr_reader :number, :guesses

  def initialize
    @number = rand(100)
    @guesses = 0
  end

  def prompt
    print "Guess a number between 1 and 100 > "
    Integer(gets)
  end

  def guess_increment
    @guesses += 1
  end

  def run
    loop do
      player_number = prompt
      guess_increment
      puts "Guess: #{guesses}"
      puts compare(player_number)
      break if is_correct?(player_number)
    end
  end

  def compare(player_number)
    if player_number > number
      "Too high"
    elsif player_number < number
      "Too low"
    else
      "You win!"
    end
  end

  def is_correct?(player_number)
    player_number == number
  end
end

game = GuessingGame.new
game.run
