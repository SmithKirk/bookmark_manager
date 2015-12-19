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
    tag = Tag.create(name: params[:tags]) #may not be needed
    link = Link.create(url: params[:url], title: params[:title])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:subject' do
    @tag = params[:subject].downcase
    @links = Link.all.select{|link| link.tags.first.name.downcase == @tag}
    erb :'tags/subject'
  end

  run! if app_file == $0
end
