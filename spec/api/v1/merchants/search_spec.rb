require 'rails_helper'

describe 'Merchants search' do
  describe 'find one MERCHANT based on search criteria name' do
    it 'search is case insensitive' do
      merchant = create(:merchant, name: 'V place')

      get "/api/v1/merchants/find?name=v"

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to be_a(Hash)
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data]).to be_a(Hash)

      expect(result[:data][:attributes]).to have_key(:name)
      expect(result[:data][:attributes][:name]).to be_a(String)
      expect(result[:data][:attributes][:name]).to eq(merchant.name)
    end
  end
end
