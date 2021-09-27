class BooksSerializer
  include JSONAPI::Serializer

  def self.destination_books(books, forecast, location)
    {
      data: {
        id: nil,
        type: 'books',
        attributes: {
          destination: location,
          forecast: forecast,
          total_books_found: books[:total_books_found],
          books: books[:books]
        }
      }
    }
  end
end
