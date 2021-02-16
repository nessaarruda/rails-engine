require 'rails_helper'

RSpec.describe 'Get all items', type: :request do
  describe 'happy path' do
    it 'can return all items' do
      create_list(:item, 100)

      get '/api/v1/items'

      expect(response).to have_http_status(:success)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(100)

      parsed[:data].each do |item|
        expect(item).to be_a(Hash)

        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:attributes)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end
    it 'returns 20 items per page' do
      create_list(:item, 100)

      get '/api/v1/items', params: { limit: 20 }

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(20)
    end
  end
end
