require 'rails_helper'

RSpec.describe 'Get all merchants', type: :request do
  describe 'happy path' do
    it 'can return all merchants 20 per page' do
      create_list(:merchant, 100)

      get '/api/v1/merchants/merchants', params: { limit: 20 }

      merchants = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(merchants['data'].count).to eq(20)
    end
  end
end
