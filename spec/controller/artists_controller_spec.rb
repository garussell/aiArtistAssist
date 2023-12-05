require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  describe "current_password_match?" do
    let(:artist) { Artist.create!(name: "Bob", email: "fake@gmail.com", style: "Pop", bio: "I'm a singer", password: "123") }

    it "returns true if current password matches" do
      params = { artist: { current_password: "123" } }
    
      expect(controller.send(:current_password_match?, artist, params)).to eq(true)
    end
    
    it "returns false if current password does not match" do
      params = { artist: { current_password: "wrong" } }
    
      expect(controller.send(:current_password_match?, artist, params)).to eq(false)
    end
  end
end