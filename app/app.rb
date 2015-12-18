ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative './data_mapper_setup'
require_relative 'models/link.rb'
require_relative 'models/tag.rb'


class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    tag = Tag.create(params[:tags])
    Link.create(url: params[:url], title: params[:title], tags: [tag])
    redirect to('/links')
  end

  run! if app_file == $0
end
