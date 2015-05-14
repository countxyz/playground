require 'rails_helper'

RSpec.describe 'users routing' do
  it 'routes users' do
    expect(get: '/').
      to route_to(controller: 'users', action: 'dashboard')

    expect(get: '/dashboard').
      to route_to(controller: 'users', action: 'dashboard')

    expect(get: '/profile').to route_to controller: 'users', action: 'show'
  end
end
