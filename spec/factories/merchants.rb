FactoryBot.define do
  factory :merchant do
    name { Faker::Music::Rush.player }
  end
end
