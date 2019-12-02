class NotificationMailer < ApplicationMailer
  default from: "fukuta.yudai@gmail.com"

  def send_confirm_to_user(post)
    mail(
      subject: "ご家族さまのお写真が掲載されました",
      to: post.profile.email,
    ) do |format|
      format.text
    end
  end
end
