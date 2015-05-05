require 'rails_helper'

RSpec.describe Contact do

  describe 'Associations' do
    it { is_expected.to belong_to :user }

    it { is_expected.to have_one(:note).dependent :destroy }

    it { is_expected.to have_many(:fax_phones).dependent :destroy    }
    it { is_expected.to have_many(:home_phones).dependent :destroy   }
    it { is_expected.to have_many(:mobile_phones).dependent :destroy }
    it { is_expected.to have_many(:office_phones).dependent :destroy }

    it { is_expected.to have_many(:emails).dependent :destroy }
    it { is_expected.to have_many(:phones).dependent :destroy }
  end

  describe 'Lengths' do
    it { is_expected.to validate_length_of(:first_name).is_at_most 50  }
    it { is_expected.to validate_length_of(:last_name).is_at_most 50   }
    it { is_expected.to validate_length_of(:company).is_at_most 50     }
  end

  describe 'Presence' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name  }
  end

  describe 'Default scope' do
    it 'returns accounts in descending order by updated_at value' do
      older_contact = create :contact, updated_at: 2.days.ago
      newer_contact = create :contact, updated_at: 1.day.ago
      expect(Contact.all).to eq [newer_contact, older_contact]
    end
  end

  describe 'Contact name' do
    it 'joins first and last_name' do
      expect(build(:contact).full_name).to eq 'a a'
    end
  end
end
