class EmailMailer < ActionMailer::Base
  def test_email
    from 'xx@gmail.com'
    to 'some@xx.com'
    subject "This is test email"
    message "It should get delivered to recipient inbox"
  end
end
