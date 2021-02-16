require 'rails_helper'

describe 'Merchants search' do
  describe 'find one MERCHANT based on search criteria' do
    it 'matches are case insensitive' do
      merchant = create(:merchant, name: 'The Brand Label')

      get '/api/v1/merchants/find?name=brand'

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
