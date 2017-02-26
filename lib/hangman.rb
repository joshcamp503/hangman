def pick_random_line
  random_line = nil

	File.open("5desk.txt") do |file|
  	file_lines = file.readlines()
  	word_list = []
		file_lines.map do |str|
  		word = str.strip
  		word_list << word if word.length > 5 && word.length < 12
		end
		p word_list
	end

end 

pick_random_line