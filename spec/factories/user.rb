FactoryBot.define do
  pw = RandomData.random_sentence
  factory :user do
    name RandomData.random_name
    sequence(:email){|n| "name#{n}@factory.com"}
    password pw
    password_confirmation pw
    confirmed_at Date.today
  end
end
