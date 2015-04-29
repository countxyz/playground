require 'rails_helper'

RSpec.feature 'signing in' do
  scenario 'signing in with form' do
    user = create :user

    visit '/'
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Welcome Back!'
  end
end
