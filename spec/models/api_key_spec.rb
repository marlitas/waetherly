require 'rails_helper'

RSpec.describe ApiKey do
 it {should belong_to(:user)}
end
