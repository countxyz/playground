FactoryGirl.define do
  sequence(:name) { |n| "account#{n}" }

  factory :account do
    name { generate :name }
    slug { generate :name }
  end
end
