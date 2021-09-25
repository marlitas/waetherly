require 'rails_helper'

RSpec.describe 'forecast requests' do
  describe 'index' do
    before(:each) do
    end

    describe 'forecast contains' do
      it 'current weather' do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast[:data]).to have_key(:id)

        expect(forecast).to have_key(:type)
        expect(forecast[:type]).to eq('forecast')

        expect(forecast[:data]).to have_key(:attributes)
        expect(forecast[:data][:attributes]).to be_a(Hash)

        expect(forecast[:data][:attributes]).to have_key(:current_weather)
        expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:datetime)
        expect(forecast[:data][:attributes][:current_weather]).to be_a(String)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunrise)
        expect(forecast[:data][:attributes][:current_weather]).to be_a(String)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:sunset)
        expect(forecast[:data][:attributes][:current_weather]).to be_a(String)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:temperature)
        expect(forecast[:data][:attributes][:current_weather][:temperature]).to be_a(Float)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:feels_like)
        expect(forecast[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:humidity)
        expect(forecast[:data][:attributes][:current_weather][:humidity]).to be_a(Float)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:visibility)
        expect(forecast[:data][:attributes][:current_weather][:visibility]).to be_a(Float)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:conditions)
        expect(forecast[:data][:attributes][:current_weather][:conditions]).to be_a(String)

        expect(forecast[:data][:attributes][:current_weather]).to have_key(:icon)
        expect(forecast[:data][:attributes][:current_weather][:icon]).to be_a(String)

        expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:timezone)
        expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:dew_point)
        expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:wind_speed)
      end

      it 'daily weather' do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast[:data][:attributes]).to have_key(:daily_weather)
        expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)

        forecast[:data][:attributes][:daily_weather].each do |day|
          expect(day).to have_key(:date)
          expect(day[:date]).to be_a(String)

          expect(day).to have_key(:sunrise)
          expect(day[:sunrise]).to be_a(String)

          expect(day).to have_key(:sunset)
          expect(day[:sunset]).to be_a(String)

          expect(day).to have_key(:max_temp)
          expect(day[:max_temp]).to be_a(Float)

          expect(day).to have_key(:min_temp)
          expect(day[:min_temp]).to be_a(Float)

          expect(day).to have_key(:conditions)
          expect(day[:conditions]).to be_a(String)

          expect(day).to have_key(:icon)
          expect(day[:icon]).to be_a(String)

          expect(day).to_not have_key(:humidity)
          expect(day).to_not have_key(:visibility)
          expect(day).to_not have_key(:feels_like)
        end

      end

      it 'hourly weather' do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
        expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)

        forecast[:data][:attributes][:hourly_weather].each do |hour|
          expect(hour).to have_key(:time)
          expect(hour[:time]).to be_a(String)

          expect(hour).to have_key(:temperature)
          expect(hour[:temperature]).to be_a(Float)

          expect(hour).to have_key(:conditions)
          expect(hour[:conditions]).to be_a(String)

          expect(hour).to have_key(:icon)
          expect(hour[:icon]).to be_a(String)

          expect(hour).to_not have_key(:max_temp)
          expect(hour).to_not have_key(:min_temp)
          expect(hour).to_not have_key(:date)
        end
      end
    end

   describe 'create' do
     it 'can create a new item' do
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
