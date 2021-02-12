require 'rails_helper'

RSpec.describe 'Get all items for one merchants', type: :request do
  describe 'happy path' do
    it 'can return items for one merchant based on id' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to have_http_status(:success)

      items = JSON.parse(response.body)
    end
  end
end
