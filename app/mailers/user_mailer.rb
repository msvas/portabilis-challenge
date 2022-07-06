class UserMailer < Devise::Mailer

  def welcome(record, opts={})
    @user = record
    devise_mail(record, :welcome, opts)
  end
  
end
