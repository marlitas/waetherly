class BookFacade
  def self.get_books(place, quantity)
    place = place.split(',').first
    response = BookService.get_books(place)
    books = {
      total_books_found: response[:numFound],
      books: response[:docs].map do |book|
        Book.new(book)
      end
      }
  end
end
