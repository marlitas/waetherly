class WeatherFacade
  def self.get_forecast(location)
    lat_lng = location[:results].first[:locations].first[:latLng]
    Forecast.new(WeatherService.get_forecast(lat_lng))
  end

  def self.get_forecast_snippet(location)
    lat_lng = location[:results].first[:locations].first[:latLng]
    response = WeatherService.get_forecast(lat_lng)
    forecast = {
      summary: response[:current][:weather].first[:description],
      temperature: "#{response[:current][:temp]} F"
      }
  end

  def self.get_arrival_forecast(location, length)
    if length == 'impossible route'
      arrival_forecast = {}
    else
      lat_lng = location[:results].first[:locations].first[:latLng]
      response = WeatherService.get_forecast(lat_lng)
      arrival_time = Time.at(response[:current][:dt]) + (Time.parse(length).hour * 60 * 60) + (Time.parse(length).min * 60)
      arrival_forecast = response[:hourly].find do |hour|
        Time.at(hour[:dt]) > arrival_time
      end
    end
  end
end
