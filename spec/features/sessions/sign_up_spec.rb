require 'rails_helper'

RSpec.feature 'Sign Up' do
  before do
    visit '/'
    click_link 'Sign Up'
  end

  scenario 'Successful sign up' do
    fill_in 'Email', with: 'user@example.com'
    within('.user_password') { fill_in 'Password', with: 'password' }
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content 'Sign up successful'
    expect(page.current_url).to eq dashboard_url
  end

  scenario 'unsuccessful sign up' do
    click_button 'Sign Up'

    expect(page).to have_content 'Sign up unsuccessful'
    expect(page.current_url).to eq users_url
  end
end
