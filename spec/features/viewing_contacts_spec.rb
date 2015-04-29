require 'rails_helper'

RSpec.feature 'Viewing Contacts' do
  let!(:contact) { create :contact }

  scenario 'Listing all accounts' do
    signin_as!(create :user)
    visit '/contacts'

    create :contact, first_name: 'a', last_name: 'a'
    expect(page).to have_content contact.full_name

    click_link contact.full_name
    expect(page.current_url).to eq(contact_url contact )
  end
end
