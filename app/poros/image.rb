class Image
  def initialize(data, location)
    @location = location
    @image_url = data[:urls][:full]
    @credit = credit_hash(data[:user])
  end

  def credit_hash(data)
    {
      source: 'unsplash.com',
      photographer: data[:name],
      photographer_url: "#{data[:links][:html]}?utm_source=weatherly&utm_medium=referral"
    }
  end
end
