require 'rubygems'
require 'rack'

# Trigger site updates from post-commit-hook on github
class Hookr
  def call(env)
    @request = Rack::Request.new(env)
    @response = Rack::Response.new
    if @request.params['payload']
      @response.write "Updating..."
      #system "date && cd /home/rubyftw/rubyftw.workspace && rake site:update 2>&1 |tee -a /home/rubyftw/update.log"
      command = "bash -lc 'cd /home/rubyftw/rubyftw.workspace && rake site:update"
      command << " FORCE=forced" if @request.params['force']
      command << " 2>&1'" 
      log = `#{command}`
      File.open("/home/rubyftw/update.log", "a") do |f| 
        f.puts Time.now
        f.puts @request.params.inspect
        f.puts log
      end
      @response.write "<pre>"
      @response.write(log)
      @response.write "</pre>"
      @response.write("done")
    else
      @response.write("eh?")
    end
    @response.finish
  end
end

use Rack::Lint
run Hookr.new
