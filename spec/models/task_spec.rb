require 'rails_helper'

RSpec.describe Task do

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Lengths' do
    it { is_expected.to validate_length_of(:title).is_at_most 50        }
    it { is_expected.to validate_length_of(:description).is_at_most 200 }
  end

  describe 'Presence' do
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :title       }
  end

  describe 'Default scope' do
    it 'returns only tasks that are incomplete' do
      complete_task   = create :task, complete: true
      incomplete_task = create :task, complete: false
      expect(Task.all).to eq [incomplete_task]
    end

    it 'returns tasks in descending order by deadline date' do
      further_deadline = create :task, deadline: Date.today + 2.weeks
      closer_deadline  = create :task, deadline: Date.today + 1.week
      expect(Task.all).to eq [closer_deadline, further_deadline]
    end
  end
end
