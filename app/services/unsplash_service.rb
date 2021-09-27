class UnsplashService
  def self.connect
    Faraday.new(url: 'https://api.unsplash.com') do |req|
      req.headers['Authorization'] = 'Client-ID ' + ENV['unsplash_access']
    end
  end

  def self.get_image(query)
    response = connect.get("/search/photos?query=#{query}&orientation=landscape")
    JSON.parse(response.body, symbolize_names: true)
  end
end
