source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem 'rails', '~> 7.0', '>= 7.0.1'

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use Puma as the app server
gem "puma", "~> 5.0"
# Manage modern JavaScript using ESM without transpiling or bundling
gem "importmap-rails", ">= 0.3.4"
# Hotwire's SPA-like page accelerator. Read more: https://turbo.hotwired.dev
gem 'turbo-rails', '~> 1.0', '>= 1.0.1'
# Hotwire's modest JavaScript framework for the HTML you already have. Read more: https://stimulus.hotwired.dev
gem 'stimulus-rails', '~> 1.0', '>= 1.0.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use JavaScript bundler
gem "jsbundling-rails"
# Use CSS bundler
gem "cssbundling-rails"
# Use Tailwind CSS. See: https://github.com/rails/tailwindcss-rails
# gem "tailwindcss-rails", "~> 0.4.3"

# Use Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variant
# gem "image_processing", "~> 1.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

gem "rexml"

gem "sprockets-rails"

gem "activemodel-embedding"

gem "kaminari"

gem "elasticsearch-model"
gem "elasticsearch-rails"
gem "elasticsearch-dsl"
gem 'bonsai-elasticsearch-rails'

gem "marc"
gem "zoom"
gem "activerecord-import",
  github: "zdennis/activerecord-import",
  branch: "activerecord7",
  require: false

gem "view_component"

gem "material_view_components", github: "mansakondo/material_view_components", branch: "main"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 4.1.0"

  # Display speed badge on every html page with SQL times and flame graphs.
  # Note: Interferes with etag cache testing. Can be configured to work on production: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem "rack-mini-profiler", "~> 2.0"
  # Speed up rails commands in dev on slow machines / big apps. See: https://github.com/rails/spring
  # gem "spring"

  "Use Pry console"
  gem "pry-rails"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
