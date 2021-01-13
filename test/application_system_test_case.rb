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

  if ENV['HUB_URL']
    Capybara::Selenium::Driver.new(app,
                                  browser: :remote,
                                  url: ENV['HUB_URL'],
                                  desired_capabilities: capabilities,
                                  options: options)

  else
    Capybara::Selenium::Driver.new(app,
                                  browser: :chrome,
                                  desired_capabilities: capabilities,
                                  options: options)
  end
end

# Default Capybara configuration
Capybara.configure do |config|
  config.save_path = Rails.root.join('tmp', 'screenshots')
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Allow use of #fixture_file_upload in system tests
  include ActionDispatch::TestProcess::FixtureFile

  driven_by :chrome_headless

  def setup
    ip_address = Socket.ip_address_list.select { |addr| addr.ipv4_private? && !addr.ipv4_loopback? }.first.ip_address

    Capybara.app_host = "http://#{ip_address}"
    Capybara.server_host = ip_address
    Capybara.always_include_port = true
  end

  def fixture_file_path(filename)
    Rails.root.join('test', 'fixtures', 'files', filename)
  end

  def remove_uploaded_files
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end

  def after_teardown
    super
    remove_uploaded_files
  end
end
