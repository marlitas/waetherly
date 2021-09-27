class Image
  attr_reader :location,
              :image_url,
              :credit,
              :id
  def initialize(data, location)
    @location = location
    @image_url = data[:urls][:full]
    @credit = credit_hash(data[:user])
    @id = nil
  end

  def credit_hash(data)
    {
      source: 'unsplash.com',
      photographer: data[:name],
      photographer_url: "#{data[:links][:html]}?utm_source=weatherly&utm_medium=referral"
    }
  end
end
