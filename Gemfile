source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.10', '< 0.6'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.1'

gem 'terser'

gem 'loofah', '~> 2.24.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'mini_racer', '~> 0.6.4'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'devise'

gem 'google-cloud-storage'

gem 'mini_magick', '~> 5.3'

gem 'font-awesome-rails'

gem 'haml-rails'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.20'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'unicorn'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.1'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'factory_girl_rails', '~> 4.9' # TODO: change to factory_bot
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.1' # TODO: remove
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.7'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 4.3'
end

group :test do
  gem 'faker', '~> 3.4', '>= 3.4.2'
end
