require 'rails_helper'

RSpec.describe 'Get all items for one merchants', type: :request do
  describe 'happy path' do
    it 'can return items for one merchant based on id' do
      merchant1 = create(:merchant)
      items1 = create_list(:item, 5, merchant_id: merchant1.id)
      merchant2 = create(:merchant)
      items2 = create_list(:item, 10, merchant_id: merchant2.id)

      get "/api/v1/merchants/#{merchant1.id}/items"

      expect(response).to have_http_status(:success)

      items = JSON.parse(response.body)

      expect(items['data'][0]['attributes']['merchant_id']).to eq(merchant1.id)
      expect(items['data'][1]['attributes']['merchant_id']).to eq(merchant1.id)
      expect(items['data'][2]['attributes']['merchant_id']).to eq(merchant1.id)
      expect(items['data'][3]['attributes']['merchant_id']).to eq(merchant1.id)
      expect(items['data'][4]['attributes']['merchant_id']).to eq(merchant1.id)
      expect(items2.first.id).to_not eq(merchant1.id)
    end
  end
end
