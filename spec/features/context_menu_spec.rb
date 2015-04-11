require 'rails_helper'

RSpec.describe 'Context Menu' do
  let(:user) { create :user }
  let(:task) { create :task }

  before do
    task.update user: user
    signin_as! user
    visit '/tasks'
  end

  context 'No interaction with page' do
    scenario 'hidden context menu' do
      expect(page).not_to have_css '.context-menu-active'
    end
  end

  context 'Interaction with page' do
    scenario 'clicking outside of task', js: true do
      find('header').right_click
      expect(page).to_not have_content 'View Task'
      expect(page).to_not have_css '.context-menu-active'
    end

    scenario 'click task', js: true do
      find('.task').right_click
      expect(page).to have_content 'View Task'
      expect(page).to have_css '.context-menu-active'
    end
  end
end
