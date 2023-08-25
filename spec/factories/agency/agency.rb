FactoryBot.define do
  factory :agencie_agencies, class: 'Agency::Record' do
    name { Faker::Name.name }
    code { SecureRandom.uuid.slice(0, 4) }
  end
end
