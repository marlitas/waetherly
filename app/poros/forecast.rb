class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id

  def initialize(data)
    @current_weather = current(data[:current])
    @daily_weather = daily(data[:daily])
    @hourly_weather = hourly(data[:hourly])
    @id = nil
  end

  def current(data)
    {
      datetime: Time.at(data[:dt]),
      sunrise: Time.at(data[:sunrise]),
      sunset: Time.at(data[:sunset]),
      temperature: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity].to_f,
      visibility: data[:visibility].to_f,
      conditions: data[:weather].first[:description],
      icon: data[:weather].first[:icon]
    }
  end

  def daily(data)
    data[0..4].map do |data|
      {
        date: Time.at(data[:dt]).to_s,
        sunrise: Time.at(data[:sunrise]).to_s,
        sunset: Time.at(data[:sunset]).to_s,
        max_temp: data[:temp][:max],
        min_temp: data[:temp][:min],
        conditions: data[:weather].first[:description],
        icon: data[:weather].first[:icon],
      }
    end
  end

  def hourly(data)
    data[0..7].map do |data|
      {
        time: Time.at(data[:dt]).to_s,
        temperature: data[:temp],
        conditions: data[:weather].first[:description],
        icon: data[:weather].first[:icon],
      }
    end
  end
end
