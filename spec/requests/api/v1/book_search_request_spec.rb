require 'rails_helper'

RSpec.describe 'book search request' do
  it 'returns current weather and related books', :vcr do
    get '/api/v1/book-search?location=denver,co&quantity=5'

    expect(response).to be_successful

    res = JSON.parse(response.body, symbolize_names: true)

    expect(res[:data]).to have_key(:id)

    expect(res[:data]).to have_key(:type)
    expect(res[:data][:type]).to eq('books')

    expect(res[:data]).to have_key(:attributes)
    expect(res[:data][:attributes]).to be_a(Hash)

    expect(res[:data][:attributes]).to have_key(:destination)
    expect(res[:data][:attributes][:destination]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:forecast)
    expect(res[:data][:attributes][:forecast]).to be_a(Hash)

    expect(res[:data][:attributes][:forecast]).to have_key(:summary)
    expect(res[:data][:attributes][:forecast][:summary]).to be_a(String)

    expect(res[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(res[:data][:attributes][:forecast][:temperature]).to be_a(String)

    expect(res[:data][:attributes]).to have_key(:total_books_found)
    expect(res[:data][:attributes][:total_books_found]).to be_an(Integer)

    expect(res[:data][:attributes]).to have_key(:books)
    expect(res[:data][:attributes][:books]).to be_an(Array)
    expect(res[:data][:attributes][:books].length).to eq(5)

    res[:data][:attributes][:books].each do |book|
      expect(book).to have_key(:isbn)
      expect(book[:isbn]).to be_an(Array)

      expect(book).to have_key(:title)
      expect(book[:title]).to be_a(String)

      expect(book).to have_key(:publisher)
      expect(book[:publisher]).to be_an(Array)
    end
  end
end
