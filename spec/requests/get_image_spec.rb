require 'rails_helper'

RSpec.describe "GetImage", type: :request do
  before do
    @artist = Artist.create(name: "Bob", email: "fake@gmail.com", style: "Pop", bio: "I'm a singer", password: "123")
  end

  describe "Instance Methods" do
    describe "#get_image" do
      it "returns ai generated image", :vcr do
        image = AiFacade.new("I want to be a singer", "Pop").get_image

        expect(image).to be_a(Hash)
        expect(image).to have_key(:image_url)

        expect(image[:image_url]).to be_a(String)
      end
    end
  end
end