module SeedHelper

  def boolean_sample
    [true, true, false].sample
  end

  def datetime_sample
    rand(2.years).seconds.ago
  end

  def random_phone_number
    rand(1111111111..9999999999).to_s
  end

  def random_phone_type
    %w( FaxPhone HomePhone MobilePhone OfficePhone ).sample
  end

  def seed_user email, first_name, last_name
    User.create(
      email:                 email,
      first_name:            first_name,
      last_name:             last_name,
      password:              'password',
      password_confirmation: 'password',
      activated:             true
    )
  end

  def seed_account name, website, user
    Account.create(
      name:       name,
      active:     boolean_sample,
      website:    website,
      created_at: datetime_sample,
      user_id:    user.id
    )
  end

  def seed_email address, klass, klass_id
    Email.create(
      address:        address,
      emailable_type: klass,
      emailable_id:   klass_id
    )
  end

  def seed_phone klass_type, klass_id
    Phone.create(
      phone_number:   random_phone_number,
      type:           random_phone_type,
      phoneable_type: klass_type,
      phoneable_id:   klass_id
    )
  end

  def seed_contact first_name, last_name, company, klass_id
    Contact.create(
      first_name: first_name,
      last_name:  last_name,
      company:    company,
      created_at: datetime_sample,
      user_id:    klass_id
    )
  end
end
