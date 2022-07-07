class UserMailer < Devise::Mailer
  default from: "msouvas@gmail.com"

  def welcome(record, opts={})
    @user = record
    devise_mail(record, :welcome, opts)
  end

end
