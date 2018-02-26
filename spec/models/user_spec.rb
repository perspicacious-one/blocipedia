require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes" do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end
  end
end
