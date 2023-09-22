5.times do
  Customer::Register::Flow.call(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    cpf: CPF.generate,
    birthdate: Faker::Date.in_date_period(year: 1990, month: 2),
    cellphone: Faker::PhoneNumber.cell_phone
  )
end

Agency::Register::Flow.call(name: Faker::Name.name)

customer = Customer::Record.last

agency = Agency::Record.last

Account::Register::Flow.call(
  customer_id: customer.id,
  agency_id: agency.id,
  account_type: :corrente
)
