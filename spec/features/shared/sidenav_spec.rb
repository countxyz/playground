require 'rails_helper'

RSpec.feature 'Sidenav' do

  scenario 'Links' do
    signin_as! create :user

    expect(page).to have_link 'Dashboard'
    expect(page).to have_link 'Accounts'
    expect(page).to have_link 'Contacts'
    expect(page).to have_link 'Tasks'
  end
end
