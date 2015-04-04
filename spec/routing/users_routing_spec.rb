require 'rails_helper'

RSpec.describe 'users routing' do
  it "routes '/profile' to users#show" do
    expect(get: '/profile').to route_to(
      controller: 'users',
      action:     'show'
    )
  end
end
