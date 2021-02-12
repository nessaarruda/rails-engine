require 'rails_helper'

RSpec.describe 'Get one merchants', type: :request do
  describe 'happy path' do
    it 'can return one merchant' do
      merchants = create_list(:merchant, 10)

      get "/api/v1/merchants/#{merchants.first.id}"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant[:data][:id].to_i).to eq(merchants.first.id)
    end
  end
end
