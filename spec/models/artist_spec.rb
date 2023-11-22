require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:style) }
    it { should validate_presence_of(:bio) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should have_many(:artist_files) }
  end
end
