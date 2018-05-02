ENV['RAILS_ENV'] ||= 'test'

#including FactoryGirl
require 'factory_girl_rails'
include FactoryGirl::Syntax::Methods

# To generate a test coverage report for the models,
# instead of just the usual `rake` to run tests, use:
# COVERAGE=true rake
require 'simplecov'
if ENV['COVERAGE']
  SimpleCov.start 'rails' do
    add_filter '/controllers|helpers/'
  end
end

# Regular test setup
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
