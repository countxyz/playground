require 'rails_helper'

RSpec.describe 'Signed In' do
  scenario 'Navigating to signin page' do
    signin_as! create :user
    visit '/signin'
    expect(page.current_url).to eq root_url
  end
end
