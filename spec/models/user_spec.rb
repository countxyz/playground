require 'rails_helper'

RSpec.describe User do

  describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
  end

  describe 'email' do
    it { should validate_presence_of(:email)                             }
    it { should validate_length_of(:email).is_at_least(5).is_at_most(50) }

    describe 'email uniqueness' do
      subject { build(:user)                                           }
      it      { should validate_uniqueness_of(:email).case_insensitive }
    end

    describe 'email format' do
      it { should allow_value('abc@xyz.com').for(:email)              }
      it { should_not allow_value('user@example,com').for(:email)     }
      it { should_not allow_value('user_at_example.com').for(:email)  }
    end
  end

  describe 'passwords' do
    it { should validate_length_of(:password).is_at_least(8).is_at_most(128) }

    describe 'password confirmation' do
      context 'without password confirmation' do
        it 'is invalid' do
          expect(build :user, password_confirmation: '').to_not be_valid
        end
      end

      context 'with password confirmation' do
        it 'is valid' do
          expect(build :user).to be_valid
        end
      end
    end
  end

  describe 'authentication' do
    context 'correct password submitted' do
      it 'authenticates successfully' do
        expect(build(:user).authenticate 'password').to be
      end
    end

    context 'incorrect password submitted' do
      it 'does not authenticate' do
        expect(build(:user).authenticate 'passwordy').to_not be
      end
    end
  end

  describe 'callbacks' do
    it 'downcases emails before saving' do
      user = create :user, email: 'USER@EXAMPLE.COM'
      expect(user.email).to eq 'user@example.com'
    end
  end
end
