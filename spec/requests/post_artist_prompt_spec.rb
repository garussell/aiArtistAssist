require 'rails_helper'

RSpec.describe "PostArtistPrompts", type: :request do
  before do
    @artist = Artist.create(name: "Bob", email: "fake@gmail.com", style: "Pop", bio: "I'm a singer", password: "123")
  end

  describe "/post_idea", :vcr do
    it "uses openAI to generate resources and action_steps for an artist" do
      post "/api/v1/#{@artist.id}/post_idea", params: { goals: "I'm writing a song about facing my fears" }

      expect(response).to be_successful
 
      response_data = JSON.parse(response.body, symbolize_names: true)

      results = response_data[:data][:attributes]

      expect(results).to have_key(:action_steps)
      expect(results[:action_steps]).to be_a(String)

      expect(results).to have_key(:resources)
      expect(results[:resources]).to be_a(Array)

      expect(results[:resources][0]).to be_a(String)

      expect(results).to have_key(:goals)
      expect(results[:goals]).to be_a(String)

      expect(results).to have_key(:image_url)
      expect(results[:image_url]).to be_a(String)
    
    end

    it "returns an error if the artist does not exist" do
      post "/api/v1/1000/post_idea", params: { goals: "I'm writing a song about facing my fears" }

      expect(response).to_not be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      results = response_data[:errors][0][:detail]

      expect(results).to eq("Artist not found")
    end

    it "returns an error if there are invalid parameters" do
      post "/api/v1/#{@artist.id}/post_idea", params: { goals: "" }

      expect(response).to_not be_successful

      response_data = JSON.parse(response.body, symbolize_names: true)

      results = response_data[:errors][0][:detail]

      expect(results).to eq("You must share your goal for this to work.")
    end
  end

  describe "cache", :vcr do
    it "caches the response for artist prompt" do
      AiService.artist_prompt("I'm writing a song about facing my fears", "gothic")
  
      expect(Rails.cache.read("artist_prompt_I'm writing a song about facing my fears_gothic")).to_not be_nil
  
      AiService.artist_prompt("I'm writing a song about facing my fears", "gothic")
  
      expect(Rails.cache.read("artist_prompt_I'm writing a song about facing my fears_gothic")[:messages]).to_not be_nil
    end
  end  
end