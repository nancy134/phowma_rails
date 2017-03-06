Devise.setup do |config|
  config.scoped_views = true
  config.mailer_sender = ENV["MAILER_REPLY"]
end
