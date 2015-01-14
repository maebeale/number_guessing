NOISY = false

def setup_game
  @target = (Random.rand(3) + 1).to_i # || @target = (1..100).to_a.sample
  @player_turns = 5 #TODO - make it so player can choose their number of turns
  @computer_turns = 0
  @player_guesses = []
  @computer_guesses = []
end

def turn(guess, target, turns, player_guesses) #TODO - make this more generic vs just player_guesses
  puts "---------------player_guesses = #{player_guesses}" if NOISY
  puts "---------------turns_start   = #{turns}" if NOISY
    while guess != target
      while turns > 0
        turns -= 1
        puts "---------------turns_current = #{turns}" if NOISY
        puts "---------------target = #{target}" if NOISY
        puts "---------------guess  = #{guess}" if NOISY
        puts "---------------player_guesses = #{player_guesses}" if NOISY

        if @player_guesses.include?(guess)
          puts "C'mon, now! Don't waste a guess on something you've already tried!"
          turns += 1
          puts "---------------turns_reset = #{turns}" if NOISY
          player_turn(@target, turns, @player_guesses)
        else
          if guess > target
            puts "Too high! Chill out!"
          else
            puts "Too low. Dream bigger!"
          end
          player_guesses << guess
          puts "---------------player_guesses == #{player_guesses}" if NOISY
          player_turn(@target, turns, @player_guesses)
        end
    end
  end
  puts "CONGRATS!!! :) You guessed the number #{target}. You had #{turns} turns left of #{turns + 5}."
end

def player_turn(target, turns, player_guesses)
  if turns == 5 #TODO - fix brittleness
    puts "Hey there! Thanks for playing the number guessing game against your computer, Eniac!"
    puts "You have 5 tries to win. Guess a number between 1 and 100 and enter here: "
  elsif turns > 0
    if turns == 1
      puts "You have #{turns} turn left. Guess again: "
    else
      puts "You have #{turns} turns left. Guess again: "
    end
  else
    puts "Sorry! You used all your #{turns + 5} turns before guessing the number #{target}, so lost. Until next time..." #TODO - fix brittleness
    play_again_prompt
  end
  player_guess = gets.chomp.to_i
  unless player_guess == target
    if player_guess > 0
      turn(player_guess, @target, turns, @player_guesses)
    else
      puts "You need to enter a *number* between 1 and 100! Guess again: "
      player_turn(target, turns, player_guesses) #TODO - get this so it doesn't start game over entirely
    end
  else
    "gaga" #TODO - get it to let you WIN the game!
  end

end

def play_again_prompt
  puts "Want to play again? If so, type 'y': "
  if gets.chomp == "y"
    setup_game
    player_turn(@target, @player_turns, @player_guesses)
  else
    puts "Thanks for playing! Hope you'll come back to play Eniac!"
    #TODO - how to end the game here?
  end
end

def computer_turn(target)
  computer_guess = rand(100)
  if computer_guess == target
    puts "Eniac guessed it!"
  else
    puts "Eniac just guessed #{computer_guess}. Give Eniac a clue to aim higher or lower."
    clue = gets.chomp_to_i
    #TODO - needs more here for hard mode...
  end

end

setup_game
player_turn(@target, @player_turns, @player_guesses) #TODO - do i have to loopdeedoo pass player_guesses, etc?