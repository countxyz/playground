require 'rails_helper'

RSpec.describe Email do

  describe 'associations' do
    it { is_expected.to belong_to :emailable }
  end

  describe 'validations' do
    it { is_expected.to allow_value('abc@xyz.com').for :address             }
    it { is_expected.to_not allow_value('user@example,com').for :address    }
    it { is_expected.to_not allow_value('user_at_example.com').for :address }

    it do
      is_expected.to validate_length_of(:address).is_at_least(5).is_at_most 50
    end
  end
end
