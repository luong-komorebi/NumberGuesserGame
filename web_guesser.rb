require 'sinatra'
require 'sinatra/reloader'

get '/' do 
    x = rand(100)
    "The SECRET NUMBER is #{x}"
end