require 'rails_helper'

RSpec.describe "PostArtistPrompts", type: :request do
  describe "/post_idea" do
    it "uses openAI to generate resources and action_steps for an artist" do
      post "/api/v1/post_idea", params: { content: "I'm writing a song about facing my fears" }

      expect(response).to be_successful
      require 'pry';binding.pry
      response_data = JSON.parse(response.body, symbolize_names: true)

      results = response_data[:data][:attributes][:results]
      require 'pry';binding.pry
    end
  end
end