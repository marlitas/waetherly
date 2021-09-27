class BookService
  def self.connect
    Faraday.new(url: 'http://openlibrary.org')
  end

  def self.get_books(place)
    response = connect.get("/search.json?place=#{place}&subject=travel")
    JSON.parse(response.body, symbolize_names: true)
  end
end
