require 'rails_helper'

RSpec.describe Account do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many(:emails).dependent(:destroy) }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'field lengths' do
    it { is_expected.to validate_length_of(:name).is_at_most 50    }
    it { is_expected.to validate_length_of(:notes).is_at_most 1000 }

    it do
      is_expected.to validate_length_of(:website).
      is_at_least(6).is_at_most 50
    end
  end

  describe 'uniqueness' do
    subject { build :account                               }
    it      { is_expected.to validate_uniqueness_of :name  }
  end

  describe 'default scope' do
    it 'returns accounts in descending order by updated_at value' do
      older_account = create :account, updated_at: 2.days.ago
      newer_account = create :account, updated_at: 1.day.ago
      expect(Account.all).to eq [newer_account, older_account]
    end
  end

  describe 'account statistics' do

    describe 'active accounts' do
      before { create_list :account, 3, active: true }

      specify { expect(Account.active_total).to eq 3       }
      specify { expect(Account.active_total).to_not eq 7   }
    end

    describe 'inactive accounts' do
      before { create_list :account, 2, active: false }

      it { expect(Account.inactive_total).to eq 2      }
      it { expect(Account.inactive_total).to_not eq 7  }
    end
  end
end
