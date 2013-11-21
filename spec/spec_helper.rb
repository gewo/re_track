require 'pry'

if RUBY_VERSION =~ /1\.9/ && RUBY_ENGINE == 'ruby'
  require 'simplecov'

  SimpleCov.start do
    add_filter "/spec/"
  end

  SimpleCov.at_exit do
    File.open(File.join(SimpleCov.coverage_path, 'percent.txt'), 'w') do |f|
      f.write SimpleCov.result.covered_percent
    end
    SimpleCov.result.format!
  end
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  # DatabaseCleaner
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner[:mongoid].start
  end

  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end
end
