require 'rails_helper'

describe 'Items CRUD' do
  describe 'create' do
    describe 'happy path' do
      it 'can create an item if all attributes are provided' do
        expect(Item.all).to eq([])
        merchant = create(:merchant)
        item = Item.create!(name: 'Jumping Rope', description: 'Its a rope and you jump', unit_price: 14.67, merchant_id: merchant.id)

        expect(Item.all).to eq([item])
        expect(item.name).to eq('Jumping Rope')
        expect(item.description).to eq('Its a rope and you jump')
        expect(item.unit_price).to eq(14.67)
      end
      it 'can return an item' do
        merchant = create(:merchant)
        item = Item.create!(name: 'Jumping Rope', description: 'Its a rope and you jump', unit_price: 14.67, merchant_id: merchant.id)

        expect(Item.where(id: item.id)).to eq([item])
      end
      it 'can update an item' do
        merchant = create(:merchant)
        item = Item.create!(name: 'Jumping Rope', description: 'Its a rope and you jump', unit_price: 14.67, merchant_id: merchant.id)

        expect(item.name).to eq('Jumping Rope')
        expect(item.description).to eq('Its a rope and you jump')
        expect(item.unit_price).to eq(14.67)

        item.update(name: 'Just Rope', description: 'Its a rope and you cant jump', unit_price: 10.67, merchant_id: merchant.id)

        expect(item.name).to eq('Just Rope')
        expect(item.description).to eq('Its a rope and you cant jump')
        expect(item.unit_price).to eq(10.67)
      end
      it 'can delete an item' do
        merchant = create(:merchant)
        item = Item.create!(name: 'Jumping Rope', description: 'Its a rope and you jump', unit_price: 14.67, merchant_id: merchant.id)

        expect(Item.all.include?(item)).to eq(true)

        item.delete

        expect(Item.all.include?(item)).to eq(false)
      end
    end
  end
end
