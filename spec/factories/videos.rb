FactoryBot.define do
  factory :video do
    youtube_url { Faker::Internet.url(host: 'youtube') }
    sharer { create(:user) }
    description { Faker::Movie.quote }
    title { Faker::Movie.title }
    youtube_id { Faker::Code.nric }
    upvote_count { Faker::Number.between(from: 1, to: 100) }
    downvote_count { Faker::Number.between(from: 1, to: 100)  }
  end
end
