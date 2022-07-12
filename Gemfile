# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem 'bcrypt', '~> 3.1.7'
gem 'blueprinter'
gem 'bootsnap', require: false
gem 'image_processing', '>= 1.2'
gem 'jwt'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.3'
gem 'rails-i18n', '~> 7.0.0'
gem 'redis', '~> 4.0'
gem 'reek'
gem 'regularity' # humanized regexp
gem 'respo'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'pry'
  gem 'pry-rails'
  gem 'rubocop-rails'
end
