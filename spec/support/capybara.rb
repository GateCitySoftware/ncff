require 'capybara/rspec' # or 'capybara/minitest' for Minitest
require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu') if Gem.win_platform?
  Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
end

Capybara.default_driver = :selenium_chrome_headless
