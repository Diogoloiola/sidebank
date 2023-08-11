class CustomerMailer < ApplicationMailer
  def welcome_email
    @customer = params[:customer]
    create_reset_password_token(@customer)
    @redirect_url = Rails.application.credentials.dig(Rails.env.to_sym, :web, :base_url)
    mail(to: @customer.email, subject: 'Bem vindo ao sidebank')
  end

  def create_reset_password_token(user)
    raw, hashed = Devise.token_generator.generate(Customer::Record, :reset_password_token)
    @token = raw
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.zone.now
    user.save
  end
end
