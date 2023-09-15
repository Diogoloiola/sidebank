FactoryBot.define do
  factory :account_accounts, class: 'Account::Record' do
    code { SecureRandom.uuid.slice(0, 4) }
    account_type { Random.rand(0..1) }
    opening_date { Faker::Date.backward(days: 5000) } # +-13 anos
    balance { Random.rand(10_000) }
    active { true }

    # Define as associações corretamente
    association :agency, factory: :agencie_agencies
    association :customer, factory: :customer_customer
  end
end
