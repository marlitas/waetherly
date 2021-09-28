require 'rails_helper'

RSpec.describe 'Weather Facade' do
  it 'returns forecast instance', :vcr do
    expect(WeatherFacade.get_forecast({results:[locations:[{latLng: {lat: '39.738453', lng: '-104.984853'} }]]})).to be_a(Forecast)
  end

  it 'returns forecast snippet', :vcr do
    expect(WeatherFacade.get_forecast_snippet({results:[locations:[{latLng: {lat: '39.738453', lng: '-104.984853'} }]]})).to eq({summary: 'scattered clouds', temperature: '80.47 F'})
  end

  it 'returns weather at arrival hour', :vcr do
    response = WeatherFacade.get_arrival_forecast({results:[locations:[{latLng: {lat: '39.738453', lng: '-104.984853'} }]]}, '05:18:00')
    expect(response).to have_key(:dt)
    expect(Time.at(response[:dt])).to be > Time.parse('2021-09-28 05:18:00')
  end
end
