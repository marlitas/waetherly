class WeatherFacade
  def self.get_forecast(location)
    lat_lng = location[:results].first[:locations].first[:latLng]
    Forecast.new(WeatherService.get_forecast(lat_lng))
  end
end
