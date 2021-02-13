require 'rails_helper'

RSpec.describe 'Get all merchants', type: :request do
  describe 'happy path' do  
    it 'return one merchant' do
      merchant = create(:merchant)
      get "/api/v1/merchants/#{merchant.id}"

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
    end
  end
end
