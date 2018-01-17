source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "3.1.11"
gem "bootstrap-datepicker-rails"
gem "bootstrap-kaminari-views"
gem "bootstrap-sass", "3.3.7"
gem "carrierwave", "~> 1.1.0"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "~> 1.7.3"
gem "filterrific"
gem "fog-aws", "2.0.0"
gem "font-awesome-rails"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick", "4.7.0"
gem "nokogiri", "1.8.1"
gem "puma", "~> 3.0"
gem "pygments.rb", "~> 0.6.3"
gem "rails", "~> 5.0.6"
gem "rails-i18n", "~> 5.0.0"
gem "ransack"
gem "redcarpet", "~> 3.3", ">= 3.3.4"
gem "sass-rails", "~> 5.0"
gem "simplemde-rails"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "sqlite3"
  gem "byebug", platform: :mri
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg", "0.18.4"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
