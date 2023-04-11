FactoryBot.define do
  factory :user do
    email  { Faker::Internet.unique.email }
    password { 'abcdef' }
    password_confirmation { 'abcdef' }
  end
end
