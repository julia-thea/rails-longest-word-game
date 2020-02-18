require 'open-uri'

class GamesController < ApplicationController
  def new
    @alphabet = 'abcdefghijklmnopqrstuvwxyz'
    @letters = Array[]
    15.times do
      r = rand 0..25
      letter = @alphabet[r]
      @letters.push(letter)
    end
    @letters
  end

  def score  
    @user_guess = params[:user_guess]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@user_guess}"
    @user_serialized = open(url).read
    @user = JSON.parse(@user_serialized)
    if !@user["found"]
      @message = "Sorry but #{@user_guess} does not seem to be a valid English word..."
    elsif @user_guess.chars.all? { |char| @user_guess.count(char) <= @letters.count(char)}
      @message = "Congratulations! #{@user_guess.upcase} is a valid English word!"
    else
      @message = "Sorry, but #{@user_guess} can't be built out of #{@letters.upcase}"
    end
  end
end
