require 'rails_helper'

RSpec.feature 'Signing In' do
  before { visit '/' }

  scenario 'Successful sign in' do
    user = create :user

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Welcome Back!'
  end

  scenario 'Unsuccessful sign in' do
    click_button 'Sign In'

    expect(page).to have_content 'Unsuccessful Sign In'
  end
end
