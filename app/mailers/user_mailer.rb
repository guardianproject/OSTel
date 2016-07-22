class UserMailer < ActionMailer::Base
  default :from => "example@example.com"

  def welcome_email(user)
    @user = user
    @url = "https://example.com/users/log_in"
    mail( :to => user.email, :subject => "Welcome to example.com")
  end
end
