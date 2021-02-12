require 'rails_helper'

RSpec.describe 'Get merchant details for one item', type: :request do
  describe 'happy path' do
    it 'can return merchant details for one item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchants"

      expect(response).to have_http_status(:success)

      merchant_details = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(merchant_details['data']['id'].to_i).to eq(merchant.id)
      expect(merchant_details['data']['type']).to eq('merchant')
      expect(merchant_details['data']['attributes']).to be_a(Hash)
      expect(merchant_details['data']['attributes']['name']).to eq(merchant.name)
    end
  end
end
