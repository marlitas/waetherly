require 'rails_helper'

RSpec.describe 'create user' do
  describe 'create' do
    it 'can create a new user' do
      create_list(:user, 4)
      old_count = User.all.count

      post '/api/v1/users', params: {
        email: 'sparky@dog.net',
        password: 'playtime',
        password_confirmation: 'playtime'
      }, as: :json
      expect(response).to be_successful

      user = JSON.parse(response.body, symbolize_names: true)

      new_count = User.all.count
      expect(user[:data]).to have_key(:id)

      expect(user[:data][:type]).to eq('users')
      expect(user[:data][:attributes][:email]).to eq('sparky@dog.net')
      expect(user[:data][:attributes]).to have_key(:api_key)
      expect(user[:data][:attributes][:api_key]).to be_a(String)
      expect(new_count).to eq(old_count + 1)
    end

    it "sends error if passwords don't match" do

    end

    it 'sends error if email already taken' do

    end

    it 'sends error if fields are missing' do
      
    end
  end
end
