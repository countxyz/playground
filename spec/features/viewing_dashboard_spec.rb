require 'rails_helper'

RSpec.feature 'Viewing Dashboard' do
  before do
    signin_as! create :user
    visit '/'
  end

  context 'Link Navigation' do
    scenario 'Navigating to Profile' do
      click_link 'Profile'

      expect(page.current_url).to eq profile_url
    end

    scenario 'Navigating to Leaderboards' do
      click_link 'Leaderboards'

      expect(page.current_url).to eq leaderboards_url
    end

    scenario 'Navigating to Dashboard' do
      click_link 'Dashboard'

      expect(page.current_url).to eq dashboard_url
    end
  end
end
