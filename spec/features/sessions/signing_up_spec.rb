require 'rails_helper'

RSpec.feature 'Signing up' do
  scenario 'Successful sign up' do
    visit '/'

    click_link 'Sign Up'
    fill_in 'Email', with: 'user@example.com'
    within('.user_password') { fill_in 'Password', with: 'password' }
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content 'Sign up successful'
  end
end
