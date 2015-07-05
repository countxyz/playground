Account.unscoped.destroy_all
Category.destroy_all
Email.destroy_all
LineItem.destroy_all
Phone.destroy_all
Product.destroy_all
Task.unscoped.destroy_all
User.destroy_all

include Sprig::Helpers
include SeedHelper

sprig [
  Account,
  Category,
  Contact,
  FaxPhone,
  HomePhone,
  LineItem,
  MobilePhone,
  OfficePhone,
  Product,
  Task,
  TollPhone,
  User
]

User.create(
  email:                 'admin@example.com',
  first_name:            'Admin',
  last_name:             'Shotcaller',
  password:              'password',
  password_confirmation: 'password',
  activated:             true,
  role:                  2
)

user = seed_user 'user@example.com', 'Bill', 'Lumbergh'
user.save

p 'This might take a while...'

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
