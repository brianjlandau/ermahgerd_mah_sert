ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"
require 'bundler'
Bundler.require(:default, (ENV['RACK_ENV'] || 'develpment').to_sym)

%w(lib initializers).each do |path|
  $LOAD_PATH.unshift(File.join(ROOT_DIR, path)) unless $LOAD_PATH.include?(File.join(ROOT_DIR, path))
end

require 'rack/static'
require 'rack/etag'
require 'active_support'
require 'active_support/core_ext'
require 'mustache_sinatra_helpers'

require 'ermahgerd'
require 'web_page_converter'

class Main < Monk::Glue
  set :app_file, __FILE__
  
  use Rack::Deflater
  use Rack::ETag
  use Rack::Static, :urls => ["/images", "/js", "/styles", "/favicon.ico"], :root => "public",
    :cache_control => 'public, max-age=86400'
  
  register Mustache::Sinatra
  set :mustache, {
     :namespace => ::Main,
     :views     => root_path('app', 'views'),
     :templates => root_path('app', 'templates')
  }
  helpers Sinatra::NiceEasyHelpers
  
  configure do
    # Load all application files.
    Dir[root_path("app/**/*.rb")].each do |file|
      require file
    end
    
    mustache_helpers Sinatra::NiceEasyHelpers
    Main::Helpers.constants.each do |const_name|
      if Main::Helpers.const_get(const_name).instance_of?(Module)
        mustache_helpers Main::Helpers.const_get(const_name)
      end
    end
  end  
end

Main.run! if Main.run?
