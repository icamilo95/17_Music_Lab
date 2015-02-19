require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'better_errors'
require 'pg'
require 'sinatra/activerecord'
require './models/artists'


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

get '/' do
   redirect to '/artists'
end

get '/artists' do
   @artists = Artist.all
   erb :index
end

get '/artists/:id/edit' do
   @artist = Artist.find params[:id].to_i
   erb :editartist
end

put '/artists/:id' do
   artist = Artist.find params[:id].to_i
   artist.update(name: params[:name])
   redirect to '/'
end

get '/artists/new' do
   erb :newartist
end

post '/artists' do
   Artist.create(name: params[:name])
   redirect to '/'
end

delete '/artists/:id' do
    artist = Artist.find params[:id].to_i
    artist.destroy
   redirect to '/'
end

