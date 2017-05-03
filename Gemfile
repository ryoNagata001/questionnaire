source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rubocop'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# slim
gem 'slim-rails'
# Bootstrap
gem 'therubyracer'
gem 'less-rails', git: 'https://github.com/MustafaZain/less-rails'
gem 'twitter-bootstrap-rails'

# Devise
gem 'devise'
# CarrierWave
gem 'carrierwave'
# config
gem 'config'
# nested form fields
gem 'nested_form_fields'
group :development do
  # エラー画面をわかりやすく整形してくれる
  gem 'better_errors'

  # better_errorsの画面上にirb/pry(PERL)を表示する
  gem 'binding_of_caller'
end
# グラフ描画
gem 'chartkick'
# 簡単で素早くjsonが作れる
gem 'active_model_serializers'
# RestfulなWEB-APIが簡単に作成できる
gem 'grape'
# slack連携
gem 'httparty'
# デバッグ用
group :development, :test do
  gem 'pry-rails'  # rails console(もしくは、rails c)でirbの代わりにpryを使われる
  gem 'pry-doc'    # methodを表示
  gem 'pry-byebug' # デバッグを実施(Ruby 2.0以降で動作する)
  gem 'pry-stack_explorer' # スタックをたどれる
end
# 非同期処理
gem "delayed_job"
gem "delayed_job_active_record"

# デプロイ先でデーモンとして動かすのに必要
gem "daemons"
# rspec
group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
end

group :test do
  gem "faker"
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem 'rails-controller-testing'
end
# do grobalise devise
gem 'devise-i18n'

# faker
gem 'faker'
