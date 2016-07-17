# Load the Rails application.
require File.expand_path('../application', __FILE__)

SMTP_CONFIG = YAML.load_file("#{Rails.root}/config/smtp.yml")[::Rails.env]

# Initialize the Rails application.
Rails.application.initialize!
