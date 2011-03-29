require 'rubygems'
require 'bundler'
Bundler.require

use Rack::Static, :urls => ["/images"], :root => "public"

require 'app/app'
run RubyFtw::App