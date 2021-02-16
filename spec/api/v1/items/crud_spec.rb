require 'rails_helper'

RSpec.describe 'Get one merchants', type: :request do
  describe 'happy path' do
    it 'returns empty array if no items exist' do
      get '/api/v1/items'

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)
      expect(parsed).to eq({ data: [] })
    end
    it 'returns one item based on id' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      get "/api/v1/items/#{item.id}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item).to have_key(:data)
      expect(item[:data]).to be_a(Hash)

      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to be_a(Hash)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)

      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
    end
    it 'can create a new item if all attributes have a value' do
      merchant = create(:merchant)
      item_params = {
        name: 'Jumping Rope',
        description: 'It is a rope and you can use for jumping',
        unit_price: 14.99,
        merchant_id: merchant.id
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item_params)

      expect(response).to be_successful
      expect(Item.last.name).to eq(item_params[:name])
      expect(Item.last.description).to eq(item_params[:description])
      expect(Item.last.unit_price).to eq(item_params[:unit_price])
    end
    it 'can update an item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      original_name = Item.last.name
      item_params = { name: "Hey, I'm new here" }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item_params)

      updated_item = Item.find_by(id: item.id)

      expect(response).to be_successful
      expect(updated_item.name).to_not eq(original_name)
      expect(updated_item.name).to eq("Hey, I'm new here")
    end
    it 'can delete an item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'can return merchant details for one item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchants"

      expect(response).to be_successful

      merchant_details = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_details[:data][:id].to_i).to eq(merchant.id)
      expect(merchant_details[:data][:type]).to eq('merchant')
      expect(merchant_details[:data][:attributes]).to be_a(Hash)
      expect(merchant_details[:data][:attributes][:name]).to eq(merchant.name)
    end
  end
end
