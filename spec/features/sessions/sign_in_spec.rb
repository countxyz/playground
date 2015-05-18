require 'rails_helper'

RSpec.feature 'Sign In' do
  before { visit '/' }

  scenario 'Successful sign in' do
    user = create :user

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Welcome Back!'
    expect(page.current_url).to eq dashboard_url
  end

  scenario 'Unsuccessful sign in' do
    click_button 'Sign In'

    expect(page).to have_content 'Unsuccessful Sign In'
    expect(page.current_url).to eq signin_url
  end
end
