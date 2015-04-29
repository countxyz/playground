require 'rails_helper'

RSpec.describe 'sessions routing' do

  it 'routes sessions' do
    expect(get: '/').to route_to controller: 'sessions', action: 'new'
    expect(get: '/signin').to route_to controller: 'sessions', action: 'new'
    expect(post: '/signin').to route_to controller: 'sessions', action: 'create'

    expect(delete: '/signout').to route_to(
      controller: 'sessions', action: 'destroy')
  end
end
