require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.create(:user) }

  describe 'factories' do
    it 'has a valid factory' do
      expect(subject).to be_valid
    end
  end

  describe 'associations' do
    it { should have_one_attached(:avatar) }

    context 'when user has an avatar' do
      let(:user_with_avatar) { FactoryBot.create(:user, :with_avatar) }

      it 'is valid with an avatar' do
        expect(user_with_avatar).to be_valid
        expect(user_with_avatar.avatar).to be_attached
      end
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password_digest) }

    context 'when user email already is registered' do
      let(:new_user) { FactoryBot.build(:user, email: subject.email) }

      it 'validates uniqueness of email' do
        expect(new_user).not_to be_valid
        expect(new_user.errors[:email]).to include('has already been taken')
      end
    end
  end
end