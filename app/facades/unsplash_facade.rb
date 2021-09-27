class UnsplashFacade
  def self.get_image(query)
    Image.new(UnsplashService.get_image(query.split(',').first)[:results].first, query)
  end
end
