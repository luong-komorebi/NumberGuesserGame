require 'sinatra'
require 'sinatra/reloader'

SECRET_NUM = rand(101)
cheat_mode = ""
message = "Guess a secret number between 0 and 100!"
end_message = ""
guess_int = nil
background = 'white'
@@remaining_guesses = 5

get '/' do 
    # initial state 
    erb :index, :locals => {:number => SECRET_NUM, :cheat_mode => cheat_mode, :message => message, :end_message => end_message, :background => background, :remaining => @@remaining_guesses} 
    if params['cheat'] == "true"
        cheat_mode = "Here you go, cheater: #{SECRET_NUM}"
    end
    if params['guess'] != nil
        end_message = ""
        guess_int = params['guess'].to_i
        message = check_guess(guess_int)
        background = check_message(message)
        @@remaining_guesses -= 1 
        if @@remaining_guesses == 0 || message == "Yes! The secret number is #{SECRET_NUM}"
            if message != "Yes! The secret number is #{SECRET_NUM}"
                end_message = "YOU LOSE!  The secret number has changed."
                background = '#A00000' 
            end
            if message == "Yes! The secret number is #{SECRET_NUM}"
                if cheat_mode != ""
                    end_message = "But you cheated, so who cares."
                    params['cheat'] = false
                    cheat_mode = ""
                else
                    end_message = "Play again!"
                    params['cheat'] = false
                    cheat_mode = ""
                end
            end
            @@remaining_guesses = 5
            SECRET_NUM = rand(101) 
            
        end
    end

    # update state of string
    erb :index, :locals => {:number => SECRET_NUM, :cheat_mode => cheat_mode, :guess => guess_int, :message => message, :end_message => end_message, :background => background, :remaining => @@remaining_guesses}
end 

def check_guess(guess)
    case guess
    when SECRET_NUM then "Yes! The secret number is #{SECRET_NUM}"
    when (SECRET_NUM+5..100) then "WAY too high!"
    when (SECRET_NUM...100) then "Too high!"
    when (0..SECRET_NUM-5) then "WAY too low!"
    when (0...SECRET_NUM) then "Too low!"
    else "error"
    end 
end

def check_message(message)
    case message
    when "Yes! The secret number is #{SECRET_NUM}" then '#BCF5A9'
    when "WAY too high!" then '#FA5858'
    when "Too high!" then '#F5A9A9'
    when "WAY too low!" then '#FA5858'
    when "Too low!" then '#F5A9A9'
    else "white"
    end
end