require 'rails_helper'

RSpec.describe "Pairs", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/pairs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/pairs/new"
      expect(response).to have_http_status(:success)
    end
  end

end
