require 'rails_helper'

RSpec.feature 'Sign In' do

  scenario 'Successful user sign in' do
    signin_as! create :user

    expect(page).to have_content 'Welcome Back!'
    expect(page.current_url).to eq dashboard_url
  end

  scenario 'Successful user sign in' do
    signin_as! create :admin

    expect(page).to have_content 'Welcome Back!'
    expect(page.current_url).to eq admin_dashboard_url
  end

  scenario 'Unsuccessful sign in' do
    visit '/'

    click_button 'Sign In'

    expect(page).to have_content 'Unsuccessful Sign In'
    expect(page.current_url).to eq signin_url
  end
end
