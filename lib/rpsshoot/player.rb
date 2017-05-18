# Player class manages user interactions
module Rpsshoot

  class Player

    attr_reader :symbol, :name

    def initialize(symbol, name)
      @symbol = symbol
      @name = name
    end

    # Each player takes a turn
    def shoot
      options = ["rock", "paper", "scissors"]
      puts "#{@name} please enter rock, paper or scissors: (or 'quit' to exit)"
      selection = STDIN.noecho(&:gets).chomp
      if options.include?(selection)
        selection
      elsif selection.downcase == "quit"
        exit
      else
        puts "I'm sorry, that wasn't a valid selection."
        shoot
      end
    end

  end

  # Computer class manages AI player in one player mode 
  class Computer < Player

    def initialize(symbol, name)
      super
    end

    # Computer takes a turn
    def shoot
      options = ["rock", "paper", "scissors"]
      shoot = options.sample
    end

  end

end
