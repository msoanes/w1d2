require 'set'

class Hangman
  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @won = false
    @lost = false
  end

  def run
    secret_length = @checking_player.pick_secret_word
    @guessing_player.receive_secret_length(secret_length)
    until game_won?
      guess = @guessing_player.guess
      response = @checking_player.check_guess(guess)
      @guessing_player.handle_guess_response(response)
    end
    puts
    puts "The word was '#{@guessing_player.word}'."
    puts "Congratulations, you guessed it!"
  end

  def game_won?
    !@guessing_player.word.include? '_'
  end
end

class Player
  attr_reader :word

  def receive_secret_length(secret_length)
    @word = "_" * secret_length
    @remaining_letters = ('a'..'z').to_a.join
    @past_guesses = []
  end

  def handle_guess_response(indices)
    indices.each do |index|
      @word[index] = @past_guesses.last
    end
  end

  def render_state
    puts
    puts "Secret word: #{@word}"
    puts "Remaining letters: #{@remaining_letters}"
  end

  def guess
    render_state
    guessed_char = make_guess
    @remaining_letters[guessed_char.ord - 97] = '.'
    @past_guesses << guessed_char
    guessed_char
  end
end

class HumanPlayer < Player
  def initialize
  end

  def pick_secret_word
    print "Please enter the LENGTH of your secret word > "
    Integer(gets)
  end

  def make_guess
    valid = false
    print 'Please enter your guess. > '

    until valid
      guessed_char = gets[0].downcase
      if ('a'..'z').include?(guessed_char) && !@past_guesses.include?(guessed_char)
        valid = true
      else
        print "Enter a single new letter from 'a' to 'z'. > "
      end
    end
    guessed_char
  end

  def check_guess(guess)
    puts
    puts "At what positions (if any) is '#{guess}' in your word?"
    print "Seperate your numbers with spaces only. > "
    gets.split.map { |index| Integer(index) - 1 }
  end
end

class ComputerPlayer < Player
  def initialize
    @words = File.readlines('dictionary.txt').map(&:chomp).to_set
  end

  def pick_secret_word
    @secret_word = @words.to_a.sample
    @secret_word.length
  end

  def make_guess
    # Working computer: guesses randomly
    update_list_of_words
    if @words.empty?
      guessed_char = guess_randomly
    else
      guessed_char = guess_cleverly
    end
    puts "#{@words.to_a.sample} is a random word!"

    puts "I'm going to guess #{guessed_char}."
    guessed_char
  end

  def guess_randomly
    ('a'..'z').to_a.select { |ch| !@past_guesses.include? ch }.sample
  end

  def guess_cleverly
    letter_count_hash = current_letter_count
    max_value = letter_count_hash.values.max
    letter_count_hash.key(max_value)
  end

  def update_list_of_words
    if @words.any? { |word| word.length != @word.length }
      @words.select! { |word| word.length == @word.length }
    end

    @words.select! do |candidate_word|
      valid = true
      @word.length.times do |index|
        if @word[index] == '_'
          valid = !@past_guesses.include?(candidate_word[index])
        else
          valid = @word[index] == candidate_word[index]
        end
        break unless valid
      end
      valid
    end
  end

  def current_letter_count
    letter_count = Hash.new(0)
    @words.each do |word|
      word.each_char do |letter|
        letter_count[letter] += 1
      end
    end
    @past_guesses.each do |past_guess|
      letter_count[past_guess] = 0
    end
    letter_count
  end

  def check_guess(guess)
    indices = []
    @secret_word.length.times do |index|
      indices << index if @secret_word[index] == guess
    end
    indices
  end
end

# game = Hangman.new(HumanPlayer.new, HumanPlayer.new)
game = Hangman.new(ComputerPlayer.new, HumanPlayer.new)
game.run
