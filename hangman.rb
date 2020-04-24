require 'yaml'
class Game
  attr_reader :secret_word, :player_guess, :underscore
 def initialize(secret_word: '', player_guess: '', underscore: '')
    @secret_word = secret_word
    @player_guess = player_guess
    @underscore = underscore
 end

 def save
  File.open('game.yaml', 'w+') do |f|  
    YAML.dump(self,f)  
  end
 end 

 def check_win;end

 def self.play_game
  #check if there is a saved file  if so load it
  if File.exist? 'game.yaml'
    puts "would you like to load the previous game(yes/no)"
    response = gets.chomp
    if response == 'yes'
     File.open('game.yaml') do |f|  
      prev_obj = YAML.load(f)  
      p Game.new(secret_word: prev_obj.secret_word, player_guess: prev_obj.player_guess, underscore: prev_obj.underscore)
      end
    end
  end
  # pick a secret word
    dictionary_array =[]
    dictionary = File.open("5desk.txt","r").readlines.each do |line|
      dictionary_array<<line.delete!("\n") 
    end
   secret_word = dictionary_array.sample
  if (5..12).include?  secret_word.length
        puts  secret_word
  end
  # create a underscore version of secret word (lets called it guessed_word)
  underscore =  secret_word.gsub(/[A-Za-z]/,'-')
  puts underscore
  
  guess_counter = 0
  # repeat until counter is at limit of guesses
    until guess_counter >  (secret_word.length )
      # increment guess counter
      guess_counter += 1
    # get users guess
      puts "Enter your guessed letter"
    player_guess = gets.chomp 
      # get all the indices that letter exists at in secret word
      array =  secret_word.split('')
      letter_indices = array.each_index do |index|
          # replace the underscores in guessed word at the found indexes above with the guessed letter
          if array[index] == player_guess
            underscore[index] = player_guess
            puts underscore
          end
      end
      new_game = Game.new(secret_word: secret_word, player_guess: player_guess, underscore: underscore)
      
      #if player input is --y save the game and exit the game
      if player_guess === '--y'
       new_game.save
       break
      end
    end
  end
  Game.play_game

end
