class UserMailer < ActionMailer::Base
  default from: "from@example.com"


  def delete_user_email(user)
    @user = user
    @url = 'www.whocares.com'
    mail(to: @user.email, subject: 'Your account got deleted')
  end
end
