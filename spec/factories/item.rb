FactoryBot.define do
  factory :item do
    name { Faker::Books::TheKingkillerChronicle.character }
    description { Faker::Movies::Lebowski.quote }
    unit_price { Faker::Number.within(range: 1..100) }
  end
end
