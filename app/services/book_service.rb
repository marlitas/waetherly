class BookService
  def connect
    Faraday.new(url: 'http://openlibrary.org')
  end

  def get_books(place)
      response = connect.get('/search.json') 
  end
end
