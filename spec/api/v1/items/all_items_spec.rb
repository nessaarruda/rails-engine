require 'rails_helper'

RSpec.describe 'Get all items', type: :request do
  describe 'happy path' do
    it 'can return all items' do
      create_list(:item, 100)

      get '/api/v1/items'

      expect(response).to have_http_status(:success)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(100)

      parsed[:data].each do |item|
        expect(item).to be_a(Hash)

        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item).to have_key(:attributes)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end
    it 'return 20 items per page' do
      create_list(:item, 100)

      get '/api/v1/items?per_page=20&page=1'

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(20)
      require "pry"; binding.pry
      expect(items[:data].pluck(:id).map(&:to_i)).to match_array(Item.first(20).pluck(:id)) # first 20 results match first 20 db
    end
    it 'returns array of data even if only one result is found' do
      # always return an array of data, even if one or zero resources are found
      create(:item)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].count).to eq(1)
    end
    it 'returns array of data even if no result are found' do

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].count).to eq(0)
    end
    it 'response doesnt include dependent data of the resource' do
      # NOT include dependent data of the resource (eg, if you’re
      # fetching items, do not send any data about item’s items or invoices)
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].include?(Item.all.first.merchant)).to eq(false)
    end
  end
end
