require 'json'
require 'rest-client'


class GamesController < ApplicationController
  def new
    @letters = []
    10.times do |letter|
      letter = ('a'..'z').to_a.shuffle.sample
      @letters << letter
    end
  end

  def score
    new
    repos = nil
    letters = params[:letters].split('')
    @word = params[:word]
    @result = ''
    response = RestClient.get "https://wagon-dictionary.herokuapp.com/#{@word}"
    repos = JSON.parse(response)
    if @word.split('') - letters != []
      @result = "Sorry but your #{@word} is baaaaad"
    elsif repos["found"] == true
      @result = "#{@word} is valid"
    else
      @result = "#{@word} is not a real word fucker"
    end
    @result
  end
end
