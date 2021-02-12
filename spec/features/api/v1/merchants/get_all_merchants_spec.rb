require 'rails_helper'

RSpec.describe 'Get all merchants' do
  describe 'happy path' do
    it 'can return all merchants' do
        merchant1 = create(:merchant, name: 'All Things')
        merchant2 = create(:merchant, name: 'Few Things')

    get '/api/v1/merchants'

    expect(response.status).to eq(200)
    end
  end
end
