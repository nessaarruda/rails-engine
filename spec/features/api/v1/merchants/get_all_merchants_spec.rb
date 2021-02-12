require 'rails_helper'

RSpec.describe 'Get all merchants', type: :request do
  describe 'happy path' do
    let!(:merchants) { FactoryBot.create_list(:random_merchant, 100)}
    before {get '/api/v1/merchants'}
    it 'can return all merchants' do
      expect(JSON.parse(response.body).size).to eq(100)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end
