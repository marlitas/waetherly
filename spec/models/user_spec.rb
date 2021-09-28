require 'rails_helper'

RSpec.describe User do
  it {should have_many(:api_keys)}
  it {should validate_presence_of(:password)}
  it {should validate_uniqueness_of(:email)}
end
