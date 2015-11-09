class ApplicationMailer < ActionMailer::Base
  default from: "Sales Department<sales@example.com>"
  layout 'mailer'
end
