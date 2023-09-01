FactoryBot.define do
  factory :transaction, class: 'Transaction::Record' do
    # TODO trocar valores para faker
    transaction_type { 1 }
    value { "9.99" }
    date_transaction { "2023-08-31" }
    origin_id { nil }
    destiny_id { nil }
    description { "MyText" }
  end
end

