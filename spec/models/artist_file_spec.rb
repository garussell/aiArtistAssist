require 'rails_helper'

RSpec.describe ArtistFile, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:topic) }
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:resources) }
    it { should validate_presence_of(:goals) }
    it { should validate_presence_of(:action_steps) }
  end

  describe 'relationships' do
    it { should belong_to(:artist) }
  end
end