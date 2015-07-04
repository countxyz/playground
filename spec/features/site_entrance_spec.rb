require 'rails_helper'

RSpec.feature 'Site Entrance' do

  context 'Logging In' do

    scenario 'Sign in page' do
      visit '/'

      expect(page).to have_link 'Sign Up'

      expect(page).to_not have_link 'Sign In'
      expect(page).to_not have_link 'Dashboard'
      expect(page).to_not have_link 'Accounts'
      expect(page).to_not have_link 'Contacts'
      expect(page).to_not have_link 'Sign Out'
    end

    scenario 'Sign in page' do
      visit '/users/new'

      expect(page).to have_link 'Sign In'

      expect(page).to_not have_link 'Sign Up'
      expect(page).to_not have_link 'Dashboard'
      expect(page).to_not have_link 'Accounts'
      expect(page).to_not have_link 'Contacts'
      expect(page).to_not have_link 'Sign Out'
    end
  end
end
