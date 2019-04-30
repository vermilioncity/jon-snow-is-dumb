class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_USERNAME']+'@'+ENV['EMAIL_DOMAIN_NAME']
  layout 'mailer'
end
