require 'rails_helper'

RSpec.describe 'Get all merchants', type: :request do
  describe 'happy path' do
    it 'can return all merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(3)

      parsed[:data].each do |merchant|

        expect(merchant).to have_key(:id)
        expect(merchant).to be_a(Hash)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
    it 'return 20 merchants per page' do
      create_list(:merchant, 100)

      get '/api/v1/merchants', params: { limit: 20}

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(20)
    end
  end
end