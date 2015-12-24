ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/link.rb'
require_relative 'models/tag.rb'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/links'
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

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
    # tag = Tag.create(name: params[:tags]) #may not be need
    # link = Link.create(url: params[:url], title: params[:title])
    link = Link.create(url: params[:url], title: params[:title])
    # tag = Tag.create(name: params[:tags])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    # @tag = params[:name].downcase
    @links = tag ? tag.links : []
    # @links = Link.all.select{|link| link.tags.first.name.downcase == @tag}
    erb :'/links/index'
  end

  run! if app_file == $0
end
