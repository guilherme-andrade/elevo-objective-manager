FactoryBot.define do
  factory :objective do
    title { Faker::Lorem.sentence }
    weight { rand(1..100) }
  end
end
