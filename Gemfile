source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "pg", "1.4.6"
gem "puma", "~> 5.0"
gem "redis", "~> 4.0"
gem "devise", "4.9.2"
gem "figaro"
gem "pagy"
gem "api-pagination"
gem "active_model_serializers", "~> 0.10.0"
gem "faker"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "rack-cors"

group :development, :test do
  gem "database_cleaner-active_record"
  gem "rspec"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "letter_opener"
  gem "pry"
end

group :development do
  gem "spring"
end
