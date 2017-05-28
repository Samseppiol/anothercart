# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


Anothercart::Application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('gmail_address'),
      port: ENV.fetch('port'),
      domain: ENV.fetch('domain'),
      authentication: ENV.fetch('authentication'),
      user_name: ENV.fetch('user_name'),
      password: ENV.fetch('password'),
      enable_starttls_auto: true
    }
end
