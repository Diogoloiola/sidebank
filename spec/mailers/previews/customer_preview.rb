# Preview all emails at http://localhost:3000/rails/mailers/customer
class CustomerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user: User.last).welcome_email
  end
end
