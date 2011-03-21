require 'helpers'

class RubyFtw < Sinatra::Base
  set :layout, :default
  set :static, true
  
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