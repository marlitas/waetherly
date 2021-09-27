require 'rails_helper'

RSpec.describe 'background photo request' do
  it 'returns image based on location', :vcr do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    res = JSON.parse(response.body, symbolize_names: true)

    expect(res[:data]).to have_key(:id)

    expect(res[:data]).to have_key(:type)
    expect(res[:data][:type]).to eq('image')

    expect(res[:data]).to have_key(:attributes)
    expect(res[:data][:attributes]).to be_a(Hash)

    expect(res[:data][:attributes]).to have_key(:location)
    expect(res[:data][:attributes][:location]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:image_url)
    expect(res[:data][:attributes][:image_url]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:credit)
    expect(res[:data][:attributes][:credit]).to be_a(Hash)

    expect(res[:data][:attributes][:credit]).to have_key(:source)
    expect(res[:data][:attributes][:credit][:source]).to be_a(String)

    expect(res[:data][:attributes][:credit]).to have_key(:photographer)
    expect(res[:data][:attributes][:credit][:photographer]).to be_a(String)

    expect(res[:data][:attributes][:credit]).to have_key(:photographer_url)
    expect(res[:data][:attributes][:credit][:photographer_url]).to be_a(String)
    expect(res[:data][:attributes][:credit][:photographer_url]).to include('utm_source=weatherly&utm_medium=referral')
  end
end
