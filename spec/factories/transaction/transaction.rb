FactoryBot.define do
  factory :transaction, class: 'Transaction::Record' do
    # TODO trocar valores para faker
    transaction_type { rand(0..2) }
    value { rand(1000) + 0.01 } # tem q ser positivo
    date_transaction { Time.backward(days: 365) } # 1 ano
    origin { FactoryBot.create :account_accounts }
    destiny { FactoryBot.create :account_accounts }
    description { Faker::Lorem.sentence(word_count: 3) }
  end
end

