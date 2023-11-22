require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /login" do
    it "returns http success" do
      post "/sessions/login"
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET /logout" do
    it "returns http success" do
      get "/sessions/logout"
      expect(response).to have_http_status(:found)
    end
  end
end
