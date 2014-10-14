
source 'https://rubygems.org'
ruby '2.1.1'

gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap_form', '~> 2.1.1'
gem 'bootstrap-sass', '~> 3.2.0.0'
gem 'carrierwave', '~> 0.10.0'
gem 'coffee-rails', '~> 4.0.1'
gem 'fabrication', '~> 2.11.3' # Including here, rather than in development/text, so that I can seed the database on Heroku.
gem 'faker', '~> 1.4.2' # Including here, rather than in development/text, so that I can seed the database on Heroku.
gem 'figaro', '~> 1.0.0'
gem 'fog', '~> 1.23.0'
gem 'foreman', '~> 0.75.0'
gem 'haml-rails'
gem 'jquery-rails', '~> 3.1.1'
gem 'mini_magick', '~> 3.8.1'
gem 'nested_form', '~> 0.3.2'
gem 'paratrooper', '~> 2.4.1'
gem 'pg', '~> 0.17.1'
gem 'rails', '~> 4.1.4'
gem 'sass-rails', '~> 4.0.3'
gem 'sentry-raven', :git => 'https://github.com/getsentry/raven-ruby.git'
gem 'sidekiq', '~> 3.2.5'
gem 'stripe', '~> 1.15.0'
gem 'uglifier', '~> 2.5.3'
gem 'unicorn', '~> 4.8.3'
gem 'virtus', '~> 1.0.3'

group :development do
  gem 'annotate', '~> 2.6.5'
  gem 'better_errors', '~> 1.1.0'
  gem 'binding_of_caller'
  gem 'letter_opener', '~> 1.2.0'
  gem 'thin', '~> 1.6.2'
end

group :development, :test do
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'pry-doc', '~> 0.6.0'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 3.0.1'
  # gem 'rspec-sidekiq', '~> 1.1.0'
end

group :test do
  gem 'capybara', '~> 2.4.1'
  gem 'capybara-email', '~> 2.4.0'
  gem 'capybara-webkit', '~> 1.3.0'
  gem 'database_cleaner', '1.2.0'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'vcr', '~> 2.9.3'
  gem 'webmock', '~> 1.19.0'
end

group :production do
  gem 'rails_12factor', '~> 0.0.2'
end
