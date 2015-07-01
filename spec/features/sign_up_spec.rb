require 'rails_helper'

RSpec.feature 'Sign Up' do
  include ActiveJob::TestHelper

  before do
    visit '/'
    click_link 'Sign Up'
  end

  scenario 'Successful sign up' do
    fill_in 'Email', with: 'user@example.com'
    within('.user_password') { fill_in 'Password', with: 'password' }
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    user = create :user
    expect(enqueued_jobs.size).to eq 1
    perform_enqueued_jobs { UserMailer.account_activation(user).deliver_now! }

    expect(page.current_url).to eq signin_url
    expect(page).to have_content 'Check email for activation link'
  end

  scenario 'unsuccessful sign up' do
    click_button 'Sign Up'

    expect(page).to have_content 'Sign up unsuccessful'
    expect(page.current_url).to eq users_url
  end
end
