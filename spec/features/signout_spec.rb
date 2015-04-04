require 'rails_helper'

RSpec.feature 'signing out' do
  scenario 'Successful signout' do
    signin_as!(create :user)
    click_link 'Sign Out'

    expect(page).to have_content 'Come back now, ya hear!'
  end
end
