require 'rails_helper'

RSpec.feature 'Viewing Accounts' do
  let!(:account) { create :account }

  scenario 'Listing all accounts' do
    signin_as!(create :user)
    visit '/accounts'

    create :account, name: 'a'
    expect(page).to have_content account.name

    click_link account.name
    expect(page.current_url).to eq(account_url account )
  end
end
