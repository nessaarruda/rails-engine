require 'rails_helper'

RSpec.describe 'Get all items for one merchants', type: :request do
  describe 'happy path' do
    it 'can return items for one merchant based on id' do
      merchant1 = create(:merchant)
      items1 = create_list(:item, 5, merchant_id: merchant1.id)
      merchant2 = create(:merchant)
      items2 = create_list(:item, 10, merchant_id: merchant2.id)

      get "/api/v1/merchants/#{merchant1.id}/items"

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data]).to be_an(Array)
      expect(parsed[:data][0]).to be_a(Hash)
      expect(parsed[:data][0]).to have_key(:attributes)
      expect(parsed[:data][0][:attributes]).to be_a(Hash)
      expect(parsed[:data][0][:attributes]).to have_key(:name)
      expect(parsed[:data][0][:attributes]).to have_key(:description)
      expect(parsed[:data][0][:attributes]).to have_key(:unit_price)
      expect(parsed[:data][0][:attributes][:unit_price]).to be_a(Float)
      expect(items2.first.id).to_not eq(merchant1.id)
    end
  end
end
