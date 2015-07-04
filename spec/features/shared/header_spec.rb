require 'rails_helper'

RSpec.feature 'Header' do

  scenario 'Non-admin' do
    signin_as! create :user

    expect(page).to_not have_link 'Admin Dashboard'
    expect(page).to_not have_link 'Sidekiq'
    expect(page).to_not have_link 'Products'
  end

  scenario 'Admin' do
    signin_as! create :admin

    expect(page).to have_link 'Admin Dashboard'
    expect(page).to have_link 'Sidekiq'
    expect(page).to have_link 'Products'
  end
end
