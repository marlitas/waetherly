class Roadtrip
    attr_reader :start_city,
                :end_city,
                :travel_time,
                :weather_at_eta,
                :id
  def initialize(from, to, length, forecast)
    @start_city = from.gsub(/,(?![ ])/, ', ')
    @end_city = to.gsub(/,(?![ ])/, ', ')
    @travel_time = length
    @weather_at_eta = weather_hash(forecast)
    @id = nil
  end

  def weather_hash(forecast)
    if forecast.nil?
      {}
    else
      {
        temperature: forecast[:temp],
        conditions: forecast[:weather].first[:description]
      }
    end
  end
end
