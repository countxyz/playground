require 'rails_helper'

RSpec.describe Task do

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'description' do
    it { should validate_length_of(:description).is_at_most(200) }
    it { should validate_presence_of(:description)               }
  end
end
