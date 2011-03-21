require 'helpers'

class RubyFtw < Sinatra::Base  
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