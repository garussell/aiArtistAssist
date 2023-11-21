require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /logout" do
    it "returns http success" do
      get "/sessions/logout"
      expect(response).to have_http_status(:success)
    end
  end

end
