require 'rails_helper'

RSpec.describe 'Map Service' do
  it 'returns latitude and longitude', :vcr do
    res = MapService.get_location('Denver,CO')
    expect(res).to have_key(:results)
    expect(res[:results].first).to have_key(:locations)
    expect(res[:results].first[:locations].first).to have_key(:latLng)
  end

  it 'gets directions', :vcr do
    res = MapService.get_directions('Denver,CO', 'Moab,UT')
    expect(res).to have_key(:route)
    expect(res[:route]).to have_key(:formattedTime)
  end
end
