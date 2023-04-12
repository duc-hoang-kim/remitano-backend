# require "capybara/poltergeist"

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.run_server = true
Capybara.app_host = 'http://localhost:4001'

Capybara.javascript_driver = :selenium_chrome
Capybara.default_driver = :selenium_chrome
Capybara.use_default_driver
