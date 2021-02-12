require 'rails_helper'

RSpec.describe 'Get all items', type: :request do
  describe 'happy path' do
    it 'can return all items 20 per page' do
      create_list(:item, 100)

      get '/api/v1/items', params: { limit: 20 }

      items = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(items['data'].count).to eq(20)
    end
  end
end
