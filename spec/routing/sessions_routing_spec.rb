require 'rails_helper'

RSpec.describe 'sessions routing' do

  it 'routes / to sessions#new' do
    expect(get: '/').to route_to(
      controller: 'sessions',
      action:     'new'
    )
  end
end
