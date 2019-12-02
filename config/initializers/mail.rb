ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: 'fukuta.yudai@gmail.com',
  password: 'Fukuta0930',
  authentication: 'login',
  enable_starttls_auto: true
}