FactoryBot.define do
  factory :transaction, class: 'Transaction::Record' do
    transaction_type { 2 }
    value { 10 }

    association :destiny, factory: :customer_customer
    association :origin, factory: :customer_customer
  end
end
