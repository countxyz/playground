require 'rails_helper'

RSpec.describe 'sessions routing' do

  it "routes '/' to sessions#new" do
    expect(get: '/').to route_to(
      controller: 'sessions',
      action:     'new'
    )
  end

  it "routes '/signin' to sessions#new" do
    expect(get: '/signin').to route_to(
      controller: 'sessions',
      action:     'new'
    )
  end

  it "routes '/signin' to sessions#create" do
    expect(post: '/signin').to route_to(
      controller: 'sessions',
      action:     'create'
    )
  end

  it "routes '/signout' to sessions#destroy" do
    expect(delete: '/signout').to route_to(
      controller: 'sessions',
      action:     'destroy'
    )
  end
end
