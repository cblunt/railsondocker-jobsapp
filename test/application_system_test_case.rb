require "test_helper"

Capybara.register_driver :chrome_headless do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions': {
      args: %w[headless no-sandbox disable-gpu disable-dev-shm-usage]
    }
  )

  if ENV["HUB_URL"]
    Capybara::Selenium::Driver.new(app,
      browser: :remote,
      url: ENV["HUB_URL"],
      capabilities: capabilities,
    )
  else
    # Fall back to default
    Capybara::Selenium::Driver.new(app,
                                  browser: :chrome,
                                  capabilities: capabilities)
  end
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :chrome_headless

  def setup
    # Fetch the IP address of the container running the specs.
    ip_address = Socket.ip_address_list.select { |addr| addr.ipv4_private? && !addr.ipv4_loopback? }.first.ip_address

    Capybara.app_host = "http://#{ip_address}"
    Capybara.server_host = "0.0.0.0"
    Capybara.always_include_port = true
  end
end
