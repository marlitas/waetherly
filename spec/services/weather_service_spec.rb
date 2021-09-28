require 'rails_helper'

RSpec.describe 'Weather Service' do
  it 'returns forecast', :vcr do
    res = WeatherService.get_forecast({lat: '39.738453', lng: '-104.984853'})
    expect(res).to have_key(:current)
    expect(res).to have_key(:hourly)
    expect(res).to have_key(:daily)
  end
end
