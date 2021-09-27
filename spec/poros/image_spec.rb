require 'rails_helper'

RSpec.describe Image do
  it 'can create a hash for image credit' do
    data = {
      urls: {
        raw: 'photos.com/raw_photo_stuff',
        full: 'photos.com/full_photo_stuff',
      },
      user: {
        id: 'asodihf',
        username: 'andrewcoop',
        name: 'Andrew Coop',
        links: {
          self: 'https://api.unsplash.com/users/andrewcoop',
          html: 'https://unsplash.com/@andrewcoop'
        }
      }
    }

    image = Image.new(data, 'denver,co')

    expected = {
      source: 'unsplash.com',
      photographer: 'Andrew Coop',
      photographer_url: 'https://unsplash.com/@andrewcoop?utm_source=weatherly&utm_medium=referral'
    }

    expect(image.credit_hash(data[:user])).to eq(expected)
  end
end
