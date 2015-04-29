require 'rails_helper'

RSpec.describe Contact do

  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of :first_name }
  end

  describe 'field lengths' do
    it { is_expected.to validate_length_of(:first_name).is_at_most 50  }
    it { is_expected.to validate_length_of(:last_name).is_at_most 50   }
    it { is_expected.to validate_length_of(:company).is_at_most 50     }
    it { is_expected.to validate_length_of(:notes).is_at_most 1000     }
  end

  describe 'default scope' do
    it 'returns accounts in descending order by updated_at value' do
      older_contact = create :contact, updated_at: 2.days.ago
      newer_contact = create :contact, updated_at: 1.day.ago
      expect(Contact.all).to eq [newer_contact, older_contact]
    end
  end
end
