class Game
  attr_accessor :game_board, :guesses, :game_over, :full_board, :random_word, :guess
  
  def initialize
    @guesses = 10
    @game_over = false
    pick_random_word
    @game_board = []
    create_board
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
    p @game_board
    puts "This word is #{@game_board.length} letters long."
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
  
  def change_board
    if @full_board.include?(@guess)
      @full_board.each_with_index do |ltr, idx|
        @game_board[idx] = ltr if ltr == @guess
      end
    else
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
  end
  	
end

Game.new