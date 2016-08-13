require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MovieReviews
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    ActionMailer::Base.smtp_settings = {
      :address        => "smtp.gmail.com",
      :port           => 587,
      :domain         => "mail.google.com",
      :user_name      => Rails.application.secrets.mail,
      :password       => Rails.application.secrets.password,
      :authentication => "login",
      :enable_starttls_auto => true
    }
  end
end
