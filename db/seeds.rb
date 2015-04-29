User.destroy_all
Task.unscoped.destroy_all
Account.unscoped.destroy_all

include Sprig::Helpers

sprig [User, Task]

user = User.create!(
  email:                 'user@example.com',
  first_name:            'Bill',
  last_name:             'Lumbergh',
  password:              'password',
  password_confirmation: 'password')

user.save

def boolean_sample
  [true, true, false].sample
end

def datetime_sample
  rand(2.years).seconds.ago
end

100.times do
  account = Account.create!(
    name:       FFaker::Company.name,
    active:     boolean_sample,
    website:    FFaker::Internet.domain_name,
    created_at: datetime_sample,
    user_id:    user )
end
