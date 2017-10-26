source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',      '~> 5.1.3'
gem 'puma',       '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier',   '>= 1.3.0'
gem 'devise',     '~> 4.3'

gem 'faker', '~> 1.8', '>= 1.8.4'

gem 'coffee-rails',   '~> 4.2'
gem 'turbolinks',     '~> 5'
gem 'jbuilder',       '~> 2.5'
gem "bulma-rails", "~> 0.5.1"
gem "font-awesome-rails"
gem 'jquery-rails',   '~> 4.3', '>= 4.3.1'
gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.2'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd', require: false
end

group :test do
  gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
  gem 'launchy', '~> 2.4', '>= 2.4.3'
  gem 'simplecov', :require => false
  gem 'brakeman', '~> 3.7', '>= 3.7.2', :require => false
end

group :production do
  gem 'pg', '~> 0.21.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
