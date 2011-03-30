require 'app/helpers/all'

module RubyFtw
  class App < Sinatra::Base
    set :views, ['app/content', 'app/css', 'app/layout']

    before do
      redirect "http://rubyftw.org#{request.path}" if request.host == "www.rubyftw.org"
    end

    get '/css/:stylesheet.css' do
      sass :"#{params[:stylesheet]}"
    end

    get '*' do
      headers 'Cache-Control' => 'public,max-age=600'
      path = params['splat'].to_s.gsub(/(^\/|\/$)/,'')
      if File.exists?("#{File.dirname(__FILE__)}/content/#{path}.erb")
        erb :"#{path}"
      elsif File.exists?("#{File.dirname(__FILE__)}/content/#{path}/index.erb")
        erb :"#{path}/index"
      else
        raise Sinatra::NotFound
      end
    end

    not_found do
      erb :missing
    end

    helpers do
      include Helpers

      def find_template(views, name, engine, &block)
        Array(views).each {|v| super(v, name, engine, &block) }
      end
    end

  end
end