require 'rails_helper'

RSpec.describe 'Business logic', type: :request do
  before :each do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id, quantity: 10)
    transaction = create(:transaction, invoice_id: invoice.id, result: 'success')
  end
  describe 'Happy path' do
    xit 'find a quantity of merchants sorted by descending revenue' do
      get '/api/v1/merchants/most_revenue?quantity=5'

      expect(response).to have_http_status(:success)

      result = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
      expect(result).to have_key(:data)
      expect(result[:data]).to be_an(Array)

      expect(result[:data][0]).to have_key(:id)
      expect(result[:data][0][:id]).to be_a(String)

      expect(result[:data][0]).to have_key(:attributes)
      expect(result[:data][0]).to be_a(Hash)

      expect(result[:data][0][:attributes]).to have_key(:name)
      expect(result[:data][0][:attributes][:name]).to be_a(String)
    end
  end
end
