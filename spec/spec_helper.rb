$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry'
require 'simplecov'

require 'capybara/flow'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| puts f; require f }
