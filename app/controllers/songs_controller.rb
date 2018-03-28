require 'rack-flash'
require 'sinatra/base'
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(name: params[:song_name])
    @artist = Artist.find_or_create_by(name: params['artist_name'])
    @song.genre_ids = params["genres"]
    @song.artist = @artist
    @song.save
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end
end
