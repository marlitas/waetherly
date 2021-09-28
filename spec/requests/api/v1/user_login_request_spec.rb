require 'rails_helper'

RSpec.describe 'User Login Request' do
  it 'can log a user in' do
    user = create(:user, password: 'password')
    post '/api/v1/sessions', params: {
      email: user.email,
      password: 'password'
    }, as: :json

    expect(response).to be_successful

    res = JSON.parse(response.body, symbolize_names: true)

    expect(res).to have_key(:data)
    expect(res[:data]).to be_a(Hash)

    expect(res[:data]).to have_key(:type)
    expect(res[:data][:type]).to eq('users')

    expect(res[:data]).to have_key(:id)
    expect(res[:data][:id]).to be_an(String)

    expect(res[:data]).to have_key(:attributes)
    expect(res[:data][:attributes]).to be_a(Hash)

    expect(res[:data][:attributes]).to have_key(:email)
    expect(res[:data][:attributes][:email]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:api_key)
    expect(res[:data][:attributes][:api_key]).to be_a(String)
  end
end
