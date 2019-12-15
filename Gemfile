source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# gem tạo các biến môi trường
gem 'figaro'
#gem dùng để xác thực
gem 'devise', '~> 4.6', '>= 4.6.2'
#gem dùng để xác thực bằng facebook
gem 'omniauth', '~> 1.9'
gem 'omniauth-facebook', '~> 5.0'

gem 'bootstrap-sass', '3.4.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
#gem dùng để upload ảnh và file, kết hợp với cả ckeditor
gem 'carrierwave', '~> 1.3', '>= 1.3.1'
gem 'ckeditor', '= 4.2.2'
gem 'mini_magick'
#gem dùng để phân quyền
gem 'pundit', '~> 2.0', '>= 2.0.1'
#gem dùng để tạo captcha
gem "recaptcha", require: "recaptcha/rails"
gem 'dotenv-rails', :require => 'dotenv/rails-now'
#gem dùng để tạo các notification xuất hiện rồi biến mất
gem 'toastr-rails', '~> 1.0', '>= 1.0.3'

gem 'active_storage_validations' #validation in active storage
# gem dùng để import file excel
gem 'roo', '~> 2.8', '>= 2.8.2'
#gem dùng để import nhanh hơn
gem 'activerecord-import'
#gem dùng để test xem query có bị N+1 không
gem 'bullet', '~> 6.0'
# gem dùng để validation sử dụng jquery
gem 'jquery-validation-rails'
# gem dùng để phân trang
gem 'will_paginate', '~> 3.1', '>= 3.1.7'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.2'
# thêm vào để sửa 1 vài lỗi ExecJS :: RuntimeError
gem 'therubyracer', '~> 0.12.3'
# kiểm tra các bản vá, bản cập nhật của gem
gem 'bundler-audit', '~> 0.6.1'
# font-awesome
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
#export file pdf
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
#save all changes to my models
gem 'paper_trail', '~> 10.3'
#gem protect application
gem 'rack-protection', '~> 2.0', '>= 2.0.5'
#redis
gem 'redis'
gem 'hiredis'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry', '~> 0.12.2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  #gem use to check security for app
  gem 'brakeman', '~> 4.5', '>= 4.5.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
