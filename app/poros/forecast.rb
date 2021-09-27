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
      datetime: Time.at(data[:dt]).strftime('%Y-%m-%d %H:%M:%S %z'),
      sunrise: Time.at(data[:sunrise]).strftime('%Y-%m-%d %H:%M:%S %z'),
      sunset: Time.at(data[:sunset]).strftime('%Y-%m-%d %H:%M:%S %z'),
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
        date: Time.at(data[:dt]).strftime('%Y-%m-%d'),
        sunrise: Time.at(data[:sunrise]).strftime('%Y-%m-%d %H:%M:%S %z'),
        sunset: Time.at(data[:sunset]).strftime('%Y-%m-%d %H:%M:%S %z'),
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
        time: Time.at(data[:dt]).strftime('%H:%M:%S %z'),
        temperature: data[:temp],
        conditions: data[:weather].first[:description],
        icon: data[:weather].first[:icon],
      }
    end
  end
end
