require 'rails_helper'

RSpec.describe 'create user' do
  describe 'create' do
    it 'can create a new user' do
      merchant = create(:merchant)
      old_count = Item.all.count

      post '/api/v1/items', params: {
        name: 'Bouncy Ball',
        description: 'It bounces',
        unit_price: 15.40,
        merchant_id: merchant.id
      }, as: :json
      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      new_count = Item.all.count
      expect(item[:data][:type]).to eq('item')
      expect(item[:data][:attributes][:name]).to eq('Bouncy Ball')
      expect(item[:data][:attributes][:description]).to eq('It bounces')
      expect(item[:data][:attributes][:unit_price]).to eq(15.40)
      expect(item[:data][:attributes][:merchant_id]).to eq(merchant.id)
      expect(new_count).to eq(old_count + 1)
    end
  end
end
