require 'rails_helper'

RSpec.feature 'hidden links' do

  context 'user without account' do
    before { visit '/' }

    scenario "able to see 'Sign Up' link" do
      assert_link_for 'Sign Up'
    end

    scenario "unable to see 'Sign In' link" do
      assert_no_link_for 'Sign In'
    end

    scenario "unable to see 'Profile' link" do
      assert_no_link_for 'Profile'
    end

    scenario "unable to see 'Accounts' link" do
      assert_no_link_for 'Accounts'
    end

    scenario "unable to see 'Contacts' link" do
      assert_no_link_for 'Contacts'
    end

    scenario "unable to see 'Sign Out' link" do
      assert_no_link_for 'Sign Out'
    end
  end

  context 'user with account' do
    before { signin_as! create :user }

    scenario "unable to see 'Sign Up' link" do
      assert_no_link_for 'Sign Up'
    end

    scenario "unable to see 'Sign In' link" do
      assert_no_link_for 'Sign In'
    end

    scenario "able to see 'Profile' link" do
      assert_link_for 'Profile'
    end

    scenario "able to see 'Sign Out' link" do
      assert_link_for 'Sign Out'
    end
  end
end
