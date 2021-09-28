require 'rails_helper'

RSpec.describe Roadtrip do
  before(:each) do
    @from = 'Denver,CO'
    @to = 'Moab,UT '
    @trip_length = '05:18:39'
    @arrival_forecast = {:dt=>1632870000,
                         :temp=>81.1,
                         :weather=>[{
                           :description=>"broken clouds",
                           :icon=>"04d"}]
                        }
    @roadtrip = Roadtrip.new(@from, @to, @trip_length, @arrival_forecast)
  end

  it 'has attributes' do
    expect(@roadtrip.start_city).to eq('Denver, CO')
    expect(@roadtrip.end_city).to eq('Moab, UT')
    expect(@roadtrip.travel_time).to eq(@trip_length)
    expect(@roadtrip.weather_at_eta).to eq({ temperature: 81.1, conditions: 'broken clouds' })
  end
end
