require 'app/helpers/all'

module RubyFtw
  class App < Sinatra::Base
    set :views, ['app/content', 'app/css', 'app/layout']
    
    get '/css/:stylesheet.css' do
      sass :"#{params[:stylesheet]}"
    end
    
    get '*' do
      path = params['splat'].to_s.sub(/^\//,'').sub(/\/$/,'')      
      if File.exists?("#{File.dirname(__FILE__)}/content/#{path}.erb")
        erb :"#{path}"
      elsif File.exists?("#{File.dirname(__FILE__)}/content/#{path}/index.erb")
        erb :"#{path}/index"
      else
        raise Sinatra::NotFound
      end
    end
    
    helpers do
      include Helpers
      
      def find_template(views, name, engine, &block)
        Array(views).each {|v| super(v, name, engine, &block) }
      end
    end
    
  end
end