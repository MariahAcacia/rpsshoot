require "rpsshoot/version"
require "io/console"
require "rpsshoot/player"

module Rpsshoot

  # Controls main game function
  class RockPaperScissors

    def initialize
      @player1 = Player.new(1, "Player 1")
      @player2 = Computer.new(2, "Computer")
      @score = []
      @instructions = instructions
    end

    # Starts game loop
    def play
      round = 0
      5.times do
        round += 1
        p1_selection = @player1.shoot
        p2_selection = @player2.shoot
        results(round, p1_selection, p2_selection)
        @score << round_winner(p1_selection, p2_selection)
      end
      determine_winner(@score)
      play_again? ? @score.clear && play : exit
    end

    # Instructions on how to play
    def instructions
      puts "Welcome to Rock, Paper, Scissors"
      puts "This is a two player game where:"
      puts "* Rock smashes Scissors"
      puts "* Scissors cut Paper"
      puts "* Paper covers Rock"
      puts "* Best out of five wins"
      pick_players
    end

    # Pick the number of players you would like to play with
    def pick_players
      puts "Would you like to play with 1 or 2 players?"
      puts "Choose 1 player to play against the computer"
      number_of_players = gets.chomp.to_i
      if number_of_players == 1
        play
      elsif number_of_players == 2
        @player2 = Player.new(2, "Player 2")
        play
      else
        puts "That was not a valid selection, please try again..."
        pick_players
      end
    end

    # Determine the winner of each round
    def round_winner(rps1, rps2)
      case rps1
      when "rock"
        rock(rps2)
      when "scissors"
        scissors(rps2)
      when "paper"
        paper(rps2)
      end
    end

    # Display results after each round
    def results(round, first, second)
      puts ">> Round #{round} results:"
      puts ">> #{@player1.name}: #{first}"
      puts ">> #{@player2.name}: #{second}"
    end

    # Rock beats Scissors, Scissors beats Paper, Paper beats Rock
    def rock(selection)
      if selection == "rock"
        puts ">> It's a tie!"
        0
      elsif selection == "scissors"
        puts ">> #{@player1.name} takes this round!"
        @player1.symbol
      elsif selection == "paper"
        puts ">> #{@player2.name} takes this round!"
        @player2.symbol
      end
    end

    def scissors(selection)
      if selection == "rock"
        puts ">> #{@player2.name} takes this round!"
        @player2.symbol
      elsif selection == "scissors"
        0
      elsif selection == "paper"
        puts ">> #{@player1.name} takes this round!"
        @player1.symbol
      end
    end

    def paper(selection)
      if selection == "rock"
        puts ">> #{@player1.name} takes this round!"
        @player1.symbol
      elsif selection == "scissors"
        puts ">> #{@player2.name} takes this round!"
        @player2.symbol
      elsif selection == "paper"
        0
      end
    end

    # Determines who wins after five rounds
    def determine_winner(array)
      p1 = array.count(@player1.symbol)
      p2 = array.count(@player2.symbol)
      if p1 > p2
        puts "Congrats! #{@player1.name} wins!"
        score
      elsif p1 < p2
        puts "Congrats! #{@player2.name} wins!"
        score
      else
        puts "You both win, it's a tie!"
        score
      end
    end

    # Displays final score
    def score
      puts ">> #{@player1.name}: #{@score.count(@player1.symbol)} wins"
      puts ">> #{@player2.name}: #{@score.count(@player2.symbol)} wins"
      puts ">> Ties: #{@score.count(0)}"
    end

    #Once game has finished, asks if they would like to play another round
    def play_again?
      puts "Would you like to play again? y/n?"
      answer = gets.chomp
      case answer
      when "n"
        false
      when "y"
        true
      end
    end

  end

end

game = Rpsshoot::RockPaperScissors.new
game.play
