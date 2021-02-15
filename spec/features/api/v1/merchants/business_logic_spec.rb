require 'rails_helper'

RSpec.describe 'Business logic', type: :request do
  before :each do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)
      @merchant_4 = create(:merchant)
      @merchant_5 = create(:merchant)
      @merchant_6 = create(:merchant)

      @item_1  = create(:item, merchant: @merchant_1)
      @item_2  = create(:item, merchant: @merchant_1)
      @item_3  = create(:item, merchant: @merchant_2)
      @item_4  = create(:item, merchant: @merchant_2)
      @item_5  = create(:item, merchant: @merchant_3)
      @item_6  = create(:item, merchant: @merchant_3)
      @item_7  = create(:item, merchant: @merchant_4)
      @item_8  = create(:item, merchant: @merchant_4)
      @item_9  = create(:item, merchant: @merchant_5)
      @item_10  = create(:item, merchant: @merchant_6)

      @invoice_1  = create(:invoice, merchant: @merchant_1, status: 'shipped')
      @invoice_2  = create(:invoice, merchant: @merchant_1, status: 'shipped')
      @invoice_3  = create(:invoice, merchant: @merchant_2, status: 'shipped')
      @invoice_4  = create(:invoice, merchant: @merchant_2, status: 'shipped')
      @invoice_5  = create(:invoice, merchant: @merchant_2, status: 'shipped')
      @invoice_6  = create(:invoice, merchant: @merchant_3, status: 'shipped')
      @invoice_7  = create(:invoice, merchant: @merchant_3, status: 'shipped')
      @invoice_8  = create(:invoice, merchant: @merchant_4, status: 'shipped')
      @invoice_9  = create(:invoice, merchant: @merchant_5, status: 'shipped')

      create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 10)
      create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 10)
      create(:invoice_item, invoice: @invoice_2, item: @item_1, quantity: 10)
      create(:invoice_item, invoice: @invoice_2, item: @item_2, quantity: 10)
      create(:invoice_item, invoice: @invoice_3, item: @item_3, quantity: 10)
      create(:invoice_item, invoice: @invoice_3, item: @item_4, quantity: 10)
      create(:invoice_item, invoice: @invoice_4, item: @item_3, quantity: 10)
      create(:invoice_item, invoice: @invoice_4, item: @item_4, quantity: 10)
      create(:invoice_item, invoice: @invoice_5, item: @item_5, quantity: 10)
      create(:invoice_item, invoice: @invoice_5, item: @item_6, quantity: 10)
      create(:invoice_item, invoice: @invoice_6, item: @item_5, quantity: 10)
      create(:invoice_item, invoice: @invoice_6, item: @item_6, quantity: 10)
      create(:invoice_item, invoice: @invoice_7, item: @item_7, quantity: 10)
      create(:invoice_item, invoice: @invoice_7, item: @item_8, quantity: 10)
      create(:invoice_item, invoice: @invoice_8, item: @item_7, quantity: 10)
      create(:invoice_item, invoice: @invoice_9, item: @item_8, quantity: 10)

      create(:transaction, invoice: @invoice_1, result: "success")
      create(:transaction, invoice: @invoice_2, result: "success")
      create(:transaction, invoice: @invoice_3, result: "failed")
      create(:transaction, invoice: @invoice_4, result: "success")
      create(:transaction, invoice: @invoice_5, result: "success")
      create(:transaction, invoice: @invoice_6, result: "success")
      create(:transaction, invoice: @invoice_7, result: "success")
      create(:transaction, invoice: @invoice_8, result: "success")
      create(:transaction, invoice: @invoice_9, result: "success")
    end
    describe 'Happy path' do
    it 'find a quantity of merchants sorted by descending revenue' do
      get '/api/v1/merchants/most_revenue?quantity=5'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_an(Array)

      expect(result[:data][0]).to have_key(:id)
      expect(result[:data][0][:id]).to be_a(String)

      expect(result[:data][0]).to have_key(:attributes)
      expect(result[:data][0]).to be_a(Hash)

      expect(result[:data][0][:attributes][:revenue]).to have_key(:name)
      expect(result[:data][0][:attributes][:revenue][:name]).to be_a(String)
    end
    it 'returns total revenue for all merchants between specific start and end date' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      invoice = create(:invoice, merchant_id: merchant.id, created_at: '2021-02-15', status: 'shipped')
      invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id, quantity: 10)
      transaction = create(:transaction, invoice_id: invoice.id, result: 'success')

      get '/api/v1/merchants/revenue?start=2021-01-01&end=2021-03-01'

      expect(response).to be_successful
      
      result = JSON.parse(response.body, symbolize_names: true)

      expect(resp).to have_key(:data)
      expect(resp[:data]).to be_a(Hash)

      expect(resp[:data]).to have_key(:attributes)
      expect(resp[:data][:attributes]).to be_a(Hash)

      expect(resp[:data][:attributes]).to have_key(:revenue)
      expect(resp[:data][:attributes][:revenue]).to be_a(Float)
    end
    it 'returns a quantity of merchants sorted by descending item quantity sold' do
      get "/api/v1/merchants/items_sold?quantity=5"

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to have_key(:data)
      expect(parsed[:data][0]).to be_a(Hash)

      expect(parsed[:data][0]).to have_key(:attributes)
      expect(parsed[:data][0][:attributes]).to be_a(Hash)

      expect(parsed[:data][0][:attributes]).to have_key(:name)
      expect(parsed[:data][0][:attributes][:name]).to be_a(String)
    end
  end
end
