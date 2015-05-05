Account.unscoped.destroy_all
Email.destroy_all
Phone.destroy_all
Task.unscoped.destroy_all
User.destroy_all

include Sprig::Helpers
include SeedHelper

sprig [User, Task]

user = seed_user 'user@example.com', 'Bill', 'Lumbergh'
user.save

100.times do
  account = seed_account(
    FFaker::Company.name, FFaker::Internet.domain_name, user )
  account.save

  seed_email FFaker::Internet.email, 'Account', account.id

  2.times { seed_phone 'Account', account.id }
end

200.times do
  contact = seed_contact(FFaker::Name.first_name, FFaker::Name.last_name,
    FFaker::Company.name, user.id )
  contact.save

  seed_email FFaker::Internet.email, 'Contact', contact.id

  2.times { seed_phone 'Contact', contact.id }
end
