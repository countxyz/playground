FactoryGirl.define do
  sequence(:name) { |n| "account#{n}" }

  factory :account do
    name { generate :name }
  end
end
