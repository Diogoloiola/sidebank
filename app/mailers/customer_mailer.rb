class CustomerMailer < ApplicationMailer
  def welcome_email
    @customer = params[:customer]
    create_reset_password_token(@customer)
    @redirect_url = Rails.application.credentials.dig(Rails.env.to_sym, :web, :base_url)
    mail(to: @customer.email, subject: 'Bem vindo ao sidebank')
  end
end
