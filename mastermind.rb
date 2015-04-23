class Game
  def initialize
    @secret_password = Password.random
    @won = false
  end

  def prompt_guess
    clean_input = ''
    loop do
      print "Please type in your guess for the password > "
      clean_input = sanitize_input(gets)
      break if valid_input?(clean_input)
    end
    clean_input
  end

  def valid_input?(clean_input)
    if clean_input.length != 4
      puts "Please type four characters. :("
      return false
    elsif !(clean_input =~ /^[RGBYOP]*$/)
      puts "Please only type R, G, B, Y, O, or P."
      return false
    end
    true
  end

  def sanitize_input(input)
    input.upcase.chomp
  end

  def run
    # Wanna know the password kid? Just uncomment the next line!
    # p @secret_password.peg_string
    puts "Welcome to Mastermind!"
    10.times do |guess|
      puts "This guess ##{guess + 1}."
      user_guess = Password.parse(prompt_guess)
      show_results(user_guess)
      break if @won
    end
    game_over
  end

  def show_results(user_guess)
    exact, near = @secret_password.exact_and_near_matches(user_guess)
    @won = true if exact == 4
    puts "You have #{near} near matches."
    puts "You have #{exact} exact matches."
  end

  def game_over
    if @won
      puts "You got it exactly right. You win!"
    else
      puts "Sorry, you're out of tries :c"
      puts "You lost."
    end
  end
end

class Password
  attr_reader :peg_string
  COLORS = %w(R G B Y O P)

  def initialize(peg_string)
    @peg_string = peg_string
  end

  def self.random
    secret_pegs = ""
    4.times { secret_pegs += COLORS.sample }
    self.new(secret_pegs)
  end

  def self.parse(user_pegs)
    self.new(user_pegs) if self.valid_input?(user_pegs)
  end

  def self.valid_input?(user_pegs)
    return false if user_pegs.length != 4

    user_pegs.each_char do |peg|
      return false unless COLORS.include? peg
    end

    true
  end

  def exact_and_near_matches(password2)
    exact = exact_matches(password2)
    near = near_matches(password2) - exact
    [exact, near]
  end

  def exact_matches(password2)
    exact_matches_count = 0
    4.times do |i|
      exact_matches_count += 1 if @peg_string[i] == password2.peg_string[i]
    end
    exact_matches_count
  end

  def near_matches(password2)
    near_matches_count = 0
    COLORS.each do |color|
      count1 = peg_string.count(color)
      count2 = password2.peg_string.count(color)
      near_matches_count += [count1, count2].min
    end
    near_matches_count
  end
end

game = Game.new
game.run
