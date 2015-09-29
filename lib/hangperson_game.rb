class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses#, :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    #@word_with_guesses = word
  end
  
  def guess(guess_letter)
    raise ArgumentError if (guess_letter =~ /[[:alpha:]]/) == nil 
    guess_letter.downcase!
    return false if (@guesses.include?(guess_letter) || @wrong_guesses.include?(guess_letter))
    
    if @word.include?(guess_letter)
      @guesses = @guesses + guess_letter
      return true
    else
      @wrong_guesses = @wrong_guesses + guess_letter
      return true
    end
  end
  
  def word_with_guesses
    guessed_letters = @guesses
    if guessed_letters == "" 
      guessed_letters = guessed_letters + " "
    end
    @word.gsub(/[^#{guessed_letters}]/i,"-")
  end
  
  def check_win_or_lose
    if @word.downcase.chars.uniq.sort == @guesses.downcase.chars.uniq.sort
      return :win
    elsif @wrong_guesses.chars.uniq.size >= 7
      return :lose
    else 
      return :play
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  

end
