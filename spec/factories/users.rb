FactoryGirl.define do
  sequence(:email) { |n| "email#{n}@example.com" }

  factory :user do
    email                 { generate :email }
    password              'password'
    password_confirmation 'password'
    activated             true

    factory :seller do
      role 1
    end

    factory :admin do
      role 2
    end
  end

  factory :unactivated_user, class: User do
    email                 { generate :email }
    password              'password'
    password_confirmation 'password'
  end
end
