class Game
  
  def initialize
    @@guesses = 10
    @@game_over = false
    pick_random_word
    create_board
    run_game
  end
  
  def pick_random_word
    word_list = []
    File.open("5desk.txt") do |file|
    	file_lines = file.readlines()
  		file_lines.map do |str|
    		word = str.strip
    		word_list << word if word.length > 5 && word.length < 12
  		end
  	end
  	@@random_word = word_list[Random.rand(0...word_list.length)]
  end
  
  def create_board
    full_board = @@random_word.split("")
    game_board = []
    full_board.map do |ltr|
      ltr = "_"
      game_board << ltr
    end
    p @@random_word
    p game_board
    puts "This word is #{game_board.length} letters long."
  end

   def run_game
    while !@@game_over
      # ask what your guess is
      guess
      # change game board
      change_board
      # check for victory

    end
  end
  
  def guess
    puts "What is your guess?"
    @guess = nil
    while @guess == nil
      input = gets.chomp.downcase
      if ("a".."z").include?(input)
        @guess = input
      else
        puts "That was not a valid guess."
        puts "What is your guess?"
      end
    end
    @@guesses -= 1
    puts "You guessed #{@guess}."
    puts "You have #{@@guesses} guesses remaining."
  end
  
  def change_board
    
  end
  	
end

Game.new