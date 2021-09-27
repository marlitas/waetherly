class WeatherService
  def self.get_forecast(location)
    response = connect.get("/data/2.5/onecall?exclude=minutely,alerts&units=imperial&lat=#{location[:lat]}&lon=#{location[:lng]}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.connect
    Faraday.new(url: 'https://api.openweathermap.org') do |req|
        req.params['appid'] = ENV['weather_key']
    end
  end
end
