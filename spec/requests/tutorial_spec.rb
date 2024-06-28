require 'rails_helper'

RSpec.describe "Tutorials", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/tutorial/index"
      expect(response).to have_http_status(:success)
    end
  end

end
