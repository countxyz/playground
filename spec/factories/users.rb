FactoryGirl.define do
  sequence(:email) { |n| "email#{n}@example.com" }

  factory :user do
    email                 { generate :email }
    password              'password'
    password_confirmation 'password'
    activated             true

    factory :admin do
      admin true
    end
  end
end
