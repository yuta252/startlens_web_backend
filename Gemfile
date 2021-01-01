source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4.4'
# Use mysql2 as the database for Active Record
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# User JWT authentication token
gem 'jwt'
# Customizing JSON response
gem 'active_model_serializers'
# Uploading image files
gem 'carrierwave'
gem 'mini_magick'
# Output error message in Japanese
gem 'rails-i18n'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Use pagination
gem 'kaminari'
# Handling environment variables
gem 'dotenv-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Create binstub to execute tests quickly with a command "bin/rspec"
  gem 'spring-commands-rspec'
  # Use static analysis tool
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
end

group :production do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
