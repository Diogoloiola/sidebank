FactoryBot.define do
  factory :transation, class: 'Transaction::Record' do
    # TODO trocar valores para faker
    transaction_type { 1 }
    value { "9.99" }
    date_transaction { "2023-08-31" }
    origin { nil }
    destiny { nil }
    description { "MyText" }
  end
end

