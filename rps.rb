MOVES = ["Paper", "Scissors", "Rock"]

def rps_compare(player_choice, computer_choice)
  if player_choice == computer_choice
    "Draw"
  elsif player_choice == MOVES[0] && computer_choice == MOVES[1]
    "Lose"
  elsif player_choice == MOVES[1] && computer_choice == MOVES[2]
    "Lose"
  elsif player_choice == MOVES[2] && computer_choice == MOVES[0]
    "Lose"
  else
    "Win"
  end
end

def rps(choice)
  computer_choice = MOVES[rand(2)]
  outcome = rps_compare(choice, computer_choice)
  return "#{computer_choice}, #{outcome}"
end

p rps("Paper")
p rps("Scissors")
p rps("Rock")
