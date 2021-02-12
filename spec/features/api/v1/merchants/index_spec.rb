require 'rails_helper'

RSpec.describe 'Get all merchants', type: :request do
  describe 'happy path' do
    it 'can return all merchants' do
      create_list(:merchant, 10)

      get '/api/v1/merchants/merchants'

      expect(response).to have_http_status(:success)
      expect(Merchant.all.count).to eq(10)
    end
  end
end
