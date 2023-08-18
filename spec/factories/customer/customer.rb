FactoryBot.define do
  factory :customer_customer, class: 'Customer::Record' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    cpf { CPF.generate }
    birthdate { Faker::Date.in_date_period(year: 1990, month: 2) }
    cellphone { Faker::PhoneNumber.cell_phone }
    skip_password_validation { true }
  end
end
