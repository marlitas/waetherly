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
end
