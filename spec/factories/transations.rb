FactoryBot.define do
  factory :transation do
    # TODO trocar valores para faker
    transaction_type { 1 }
    value { "9.99" }
    date_transaction { "2023-08-31" }
    customer_customer { nil }
    customer_customer { nil }
    description { "MyText" }
  end
end

