require 'rails_helper'

describe 'Items search' do
  describe 'find all items based on search criteria name' do
    it 'search is case insensitive' do
      item_1 = create(:item, name: 'Jumping Rope')
      item_2 = create(:item, name: 'Normaly Rope')

      get '/api/v1/items/find_all?name=rope'

      expect(response).to be_successful

      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_an(Array)

      result[:data].each do |item|
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
      end
    end
  end
end
