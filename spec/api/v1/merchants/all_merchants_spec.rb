require 'rails_helper'

RSpec.describe 'Get all merchants', type: :request do
  describe 'happy path' do
    it 'can return all merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(3)

      parsed[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant).to be_a(Hash)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
    it 'return 20 merchants per page' do
      create_list(:merchant, 100)

      get '/api/v1/merchants?per_page=20&page=1'

      expect(response).to be_successful

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data].count).to eq(20)
    end
    it 'returns array of data even if only one result is found' do
      # always return an array of data, even if one or zero resources are found
      create(:merchant)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data]).to be_an(Array)
      expect(merchants[:data].count).to eq(1)
    end
    it 'returns array of data even if no result are found' do

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data]).to be_an(Array)
      expect(merchants[:data].count).to eq(0)
    end
    it 'response doesnt include dependent data of the resource' do
      # NOT include dependent data of the resource (eg, if you’re
      # fetching merchants, do not send any data about merchant’s items or invoices)
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data]).to be_an(Array)
      expect(merchants[:data].include?(Merchant.all.first.items)).to eq(false)
    end
  end
end
