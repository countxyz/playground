require 'rails_helper'

RSpec.feature 'Hidden Links' do

  context 'Logging In' do
    scenario 'Sign in page' do
      visit '/'

      assert_link_for 'Sign Up'

      assert_no_link_for 'Sign In'
      assert_no_link_for 'Dashboard'
      assert_no_link_for 'Accounts'
      assert_no_link_for 'Contacts'
      assert_no_link_for 'Sign Out'
    end

    scenario 'Sign in page' do
      visit '/users/new'

      assert_link_for 'Sign In'

      assert_no_link_for 'Sign Up'
      assert_no_link_for 'Dashboard'
      assert_no_link_for 'Accounts'
      assert_no_link_for 'Contacts'
      assert_no_link_for 'Sign Out'
    end
  end
end
