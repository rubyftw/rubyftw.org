require 'ruby_ftw/helpers/all'

module RubyFtw
  class App < Sinatra::Base
    set :views, File.dirname(__FILE__) + '/views'
    
    get '/' do
      erb :index
    end

    get '/css/:stylesheet.css' do
      sass "css/#{params[:stylesheet]}".to_sym
    end
    
    helpers do
      include Helpers
    end
  end
end