source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Adds Devise to avoid problems with Devise Token Auth
gem "devise"

# Use Devise Token Auth for authentication using tokens
gem "devise_token_auth", ">= 1.2.0", git: "https://github.com/lynndylanhurley/devise_token_auth"

# Use Sidekiq basically for asynchronous emails
gem "sidekiq"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Uses serializers to format JSON data on responses
gem "active_model_serializers"

# Uses action caching for faster responses
gem "actionpack-action_caching"

# Cache store provider
gem "dalli"

# Helps with cache setup
gem "memcachier"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development, :test do
  # Uses RSpec framework for testing
  gem 'rspec-rails', '~> 6.0.0.rc1'
  # Creates fake data for testing
  gem 'factory_bot_rails'
  # Fake data generator
  gem 'faker'
  # Windows compatibility
  gem 'ffi'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"

  # Clear database between tests
  gem "database_cleaner"
end
