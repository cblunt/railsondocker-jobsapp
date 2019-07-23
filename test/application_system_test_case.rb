require "test_helper"

Capybara.register_driver :chrome_headless do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    loggingPrefs: {
      browser: "ALL",
      client: "ALL",
      driver: "ALL",
      server: "ALL"
    }
  )

  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless no-sandbox disable-gpu disable-dev-shm-usage]
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    options: options
  )
end

# Default Capybara configuration
Capybara.configure do |config|
  config.save_path = Rails.root.join('tmp', 'screenshots')
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :chrome_headless

  def fixture_file_path(filename)
    Rails.root.join("test", "fixtures", "files", filename)
  end

  def remove_uploaded_files
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end

  def after_teardown
    super
    remove_uploaded_files
  end
end
