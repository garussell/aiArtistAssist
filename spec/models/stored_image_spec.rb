require 'rails_helper'

RSpec.describe StoredImage, type: :model do
  describe "relationships" do
    it { should belong_to(:artist_file) }
  end

  describe "validations" do
    it { should validate_presence_of(:image) }
  end
end
