require 'yaml'

class Game
  attr_accessor :game_board, :guesses, :game_over, :full_board, :random_word, :guess
  
  def initialize
    @guesses = 10
    @game_over = false
    @game_board = []
    @incorrect = []
    pick_random_word
    create_board
    show_board
    run_game
  end
  
  def pick_random_word
    word_list = []
    File.open("5desk.txt") do |file|
    	file_lines = file.readlines()
  		file_lines.map do |str|
    		word = str.strip
    		word_list << word if word.length > 4 && word.length < 13
  		end
  	end
  	@random_word = word_list[Random.rand(0...word_list.length)]
  end
  
  def create_board
    @full_board = @random_word.split("")
    @full_board.map do |ltr|
      ltr = "_"
      @game_board << ltr
    end
  end
  
  def run_game
    while !@game_over
      # ask what your guess is
      guess
      # change game board
      change_board
      # display board
      show_board
      # check for game over
      check_game_over

    end
  end
  
  def guess
  	save
    puts "Guess a letter."
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
    puts "You guessed #{@guess}."
  end

  def save
		puts "Save game? (Y/N)"
		save = nil
		while save == nil
			save = gets.chomp.downcase
			case save
			when "y"
				file = File.open("lib/saved.yaml", "w") do |file|
        	file.write(Psych.dump(self))
    		end
    		puts "Game saved."
			when "n"
				"n"
			else
				save = nil
				puts "That was not a valid response."
		    puts "Save game? (Y/N)"
			end
		end
	end
  
  def change_board
    if @full_board.include?(@guess)
      @full_board.each_with_index do |ltr, idx|
        @game_board[idx] = ltr if ltr == @guess
      end
    else
    	@incorrect << @guess
      @guesses -= 1
    end
  end
  
  def check_game_over
    if @game_board == @full_board
      @game_over = true
      puts "You guessed the word \'#{@random_word}\'!"
      puts "VICTORY!"
    elsif @guesses == 0
      @game_over = true
      puts "Sorry, you have used all your guesses."
      puts "The word was \'#{@random_word}\'."
      puts "Game Over"
    else
      @game_over = false
      puts "You have #{@guesses} guesses remaining."
    end
  end
  
  def show_board
    p @game_board
    puts "Incorrect guesses so far: #{@incorrect.join(", ")}"
  end
  	
end


puts "Welcome to Hangman"
puts "Would you like to load a saved game? (Y/N)"
saved = nil
while saved == nil
  input = gets.chomp.downcase
  case input
  when "y"
  	puts "Loading saved game..."
  	saved = Psych.load(File.open("lib/saved.yaml"))
  	saved.show_board
  	saved.run_game
  when "n"
  	saved = !nil
  	puts "Starting new game..."
  	Game.new
  else
    puts "That was not a valid response."
    puts "Would you like to load a saved game? (Y/N)"
  end
end







