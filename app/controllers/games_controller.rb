require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { Array('A'..'Z').sample }.join
    # @letters = @letters.split('')
    # hidden_field_tag 'letter_list', @letters
  end

  def score
    @letters = params[:letter_list]
    @answer = params[:user_answer]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    nt = URI.open(filepath).read
    @web_answer = JSON.parse(nt)

    if (@answer.split('')).all? { |element| (@letters.split('')).include?(element.upcase) } == false
      @response = "Sorry but <strong>#{@answer}</strong> can't be built of #{@letters.split('')}"
    elsif @web_answer["found"] == false
      @response = "Sorry but #{@answer} does not seem to be a valid english word..."
    else
      @response = "<strong>Congragulations!</strong> #{@answer} is a valid english word"
    end
  end
end
