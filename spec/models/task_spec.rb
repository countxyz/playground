require 'rails_helper'

RSpec.describe Task do

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'title' do
    it { should validate_length_of(:title).is_at_most(50)  }
    it { should validate_presence_of(:title)               }
  end

  describe 'description' do
    it { should validate_length_of(:description).is_at_most(200) }
    it { should validate_presence_of(:description)               }
  end

  describe 'default scope' do
    it 'returns only tasks that are incomplete' do
      complete_task   = create :task, complete: true
      incomplete_task = create :task, complete: false
      expect(Task.all).to eq [incomplete_task]
    end

    it 'returns tasks in descending order by deadline date' do
      further_deadline = create :task, deadline: Date.today + 2.weeks
      sooner_deadline  = create :task, deadline: Date.today + 1.week
      expect(Task.all).to eq [sooner_deadline, further_deadline]
    end
  end
end
