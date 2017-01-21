require 'sinatra'
require 'sinatra/reloader'

get '/' do
  slim :app
end
