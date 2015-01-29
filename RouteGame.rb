#Get Gems
require 'bundler'
Bundler.require
cards = ['1', "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]
#Upload card photos
set :public_folder, 'public'
#look for the directory asked for
get '/drawrandom' do
  #randomly generate the cards specifications
  type = ['clubs', 'spades', 'diamonds', 'hearts'].sample
  card = rand(13) + 1
  #change to better cards
  if card == 1
    card = 'ace'
  elsif card == 11
    card = 'jack'
    type = type + '2'
  elsif card == 12
    card = 'queen'
    type = type + '2'
  elsif card == 13
    card = 'king'
    type = type + '2'
  end
  #send file to the screen from the public folder
  send_file File.join(settings.public_folder, "Cards/#{card.to_s.chomp}_of_#{type.to_s.chomp}.png")
end

#Input from user on card
get '/draw/:string/:object' do
  #set card specs
  type = params[:string].downcase
  card = params[:object]
  card = card.to_s.downcase

  #change to correct cards
  if cards.include?(card) || card == 'ace' || card == 'jack' || card == 'queen' || card == 'king'
    if card == "1" || card == 'ace'
      card = 'ace'
    elsif card == "11" || card == 'jack'
      card = 'jack'
      type = type + '2'
    elsif card == '12' || card == 'queen'
      card = 'queen'
      type = type + '2'
    elsif card == '13' || card == 'king'
      card = 'king'
      type = type + '2'
    end
    #send file
    send_file File.join(settings.public_folder, "Cards/#{card.to_s.chomp}_of_#{type.to_s.chomp}.png")
  else
    #if not a card then output an error
    "Not a valid card!"
  end
end
