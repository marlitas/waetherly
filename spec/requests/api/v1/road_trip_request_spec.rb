require 'rails_helper'

RSpec.describe 'Road Trip Request' do
  it 'can send new road trip request', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    api_key = ApiKey.create(token: 'asdoifjoin388fioa9', user_id: user.id )

    post '/api/v1/road_trip', params: {
      origin: 'Denver,CO',
      destination: 'Moab, UT',
      api_key: 'asdoifjoin388fioa9'
    }, as: :json

    expect(response).to be_successful

    res = JSON.parse(response.body, symbolize_names: true)

    expect(res).to have_key(:data)
    expect(res[:data]).to be_a(Hash)

    expect(res[:data]).to have_key(:type)
    expect(res[:data][:type]).to eq('roadtrip')

    expect(res[:data]).to have_key(:id)

    expect(res[:data]).to have_key(:attributes)
    expect(res[:data][:attributes]).to be_a(Hash)

    expect(res[:data][:attributes]).to have_key(:start_city)
    expect(res[:data][:attributes][:start_city]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:end_city)
    expect(res[:data][:attributes][:end_city]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:travel_time)
    expect(res[:data][:attributes][:travel_time]).to be_a(String)


    expect(res[:data][:attributes]).to have_key(:weather_at_eta)
    expect(res[:data][:attributes][:weather_at_eta]).to be_a(Hash)

    expect(res[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(res[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

    expect(res[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    expect(res[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'sends error if api_key incorrect' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    api_key = ApiKey.create(token: 'asdoifjoin388fioa9', user_id: user.id )

    post '/api/v1/road_trip', params: {
      origin: 'Denver,CO',
      destination: 'Moab, UT',
      api_key: 'blah'
    }, as: :json

    expect(response).to_not be_successful
    expect(response.status).to eq(401)
  end

  xit 'impossible route if no roads connecting' do

  end
end
