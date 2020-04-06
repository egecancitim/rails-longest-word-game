require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split('')
    @word = params[:word].upcase.split('')

    if word_in_grid.empty?
      if check_valid_word(@word) == true
        @result = "CONGRATULATIONS! #{params[:word].upcase} is valid!"
      else
        @result = "Sorry, but #{params[:word].upcase} is not valid!"
      end
    else
      @result = 'Choose the letters from the given ones.'
    end
  end

  private

  def word_in_grid
    @word - @letters
  end

  def check_valid_word(word)
    # create the method to check if word is valid english word
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = JSON.parse(open(url).read)
    response['found']
  end
end
