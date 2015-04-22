CHOICES = %w(Paper Scissors Rock)
WINNING_MOVES = [%w(Paper Rock), %w(Rock Scissors), %w(Scissors Paper)]

def rps_compare(player_choice, computer_choice)
  return 'Draw' if player_choice == computer_choice
  return 'Win' if WINNING_MOVES.include? [player_choice, computer_choice]
  return 'Lose' if WINNING_MOVES.include? [computer_choice, player_choice]
  'Invalid'
end

def rps(choice)
  computer_choice = CHOICES[rand(2)]
  outcome = rps_compare(choice, computer_choice)
  "#{computer_choice}, #{outcome}"
end

p rps('Paper')
p rps('Scissors')
p rps('Rock')
