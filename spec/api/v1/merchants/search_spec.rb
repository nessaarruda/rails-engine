require 'rails_helper'

describe 'Merchants search' do
  describe 'find one merchant based on search criteria name' do
    it 'search is case insensitive' do
      merchant = create(:merchant, name: 'V place')

      get '/api/v1/merchants/find?name=v'

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_an(Hash)
      expect(result[:data]).to have_key(:attributes)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes][:name]).to be_a(String)
      expect(result[:data][:attributes][:name]).to eq(merchant.name)
    end
    it 'possible to query using pagination and skip pages' do

      merchants = create_list(:merchant, 100)

      get '/api/v1/merchants?per_page=20&page=5'

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(20)
      expect(parsed[:data].last[:attributes][:name]).to eq(merchants.last.name)
    end
    it 'returns empty hash when no matches are found' do
      get '/api/v1/merchants/find?name=1234'

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result).to be_an(Object)
    end
    it 'finds one merchant' do
        merchant = create(:merchant)
        get "/api/v1/merchants/find?name=#{merchant.name}"

        expect(response).to be_successful

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed).to have_key(:data)
        expect(parsed[:data]).to be_a(Hash)

        expect(parsed[:data]).to have_key(:id)
        expect(parsed[:data][:id]).to be_a(String)

        expect(parsed[:data]).to have_key(:attributes)
        expect(parsed[:data][:attributes]).to be_a(Hash)
        expect(parsed[:data][:attributes]).to have_key(:name)
        expect(parsed[:data][:attributes][:name]).to be_a(String)
        expect(parsed[:data][:attributes][:name]).to eq(merchant.name)
    end
  end
end
