class BookFacade
  def self.get_books(place, quantity)
    place = place.split(',').first
    BookService.get_books(place)
  end
end
